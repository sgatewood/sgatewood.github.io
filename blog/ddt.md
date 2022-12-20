---
title: Python data-driven testing
layout: home
parent: Blog
nav_order: 2
---

# An interesting way to do parameterized Python unit tests?

12/19/22

While testing recently I came across a potential neat pattern.

## Example code to test

Let's say we want to test this contrived function:

```python
def describe() -> str:
    a = method_a()
    b = method_b()
    if a and b:
        return "both are True"
    if a:
        return "only A is True"
    if b:
        return "only B is True"
    return "neither are True"
```

## The verbose way

Some people are die-hard fans of "one assertion per test." Here it is:

```python
import unittest
from unittest.mock import patch, MagicMock

from example.main import describe


class MyTestCase(unittest.TestCase):

    @patch("example.main.method_b")
    @patch("example.main.method_a")
    def test_neither_is_true(self, mock_method_a: MagicMock, mock_method_b: MagicMock) -> None:
        mock_method_a.return_value = False
        mock_method_b.return_value = False
        self.assertEqual("neither are True", describe())

    @patch("example.main.method_b")
    @patch("example.main.method_a")
    def test_a_is_true(self, mock_method_a: MagicMock, mock_method_b: MagicMock) -> None:
        mock_method_a.return_value = True
        mock_method_b.return_value = False
        self.assertEqual("only A is True", describe())

    @patch("example.main.method_b")
    @patch("example.main.method_a")
    def test_b_is_true(self, mock_method_a: MagicMock, mock_method_b: MagicMock) -> None:
        mock_method_a.return_value = False
        mock_method_b.return_value = True
        self.assertEqual("only B is True", describe())

    @patch("example.main.method_b")
    @patch("example.main.method_a")
    def test_both_are_true(self, mock_method_a: MagicMock, mock_method_b: MagicMock) -> None:
        mock_method_a.return_value = True
        mock_method_b.return_value = True
        self.assertEqual("both are True", describe())


if __name__ == '__main__':
    unittest.main()
```

Can't tell what it's testing from a quick glance (and double-RIP when you have more patches, and the patches end up in different orders etc).

## Side-note: Mocking in `setUp`

Sometimes the shared patching nightmare can be avoided by patching in the `setUp` method and storing the mocks as attributes.

```python
import unittest
from unittest.mock import patch, MagicMock

from example.main import describe


class MyTestCase(unittest.TestCase):

    def patch(self, *args, **kwargs) -> MagicMock:
        mock = patch(*args, **kwargs)
        self.addCleanup(mock.stop)
        return mock.start()

    def setup_mocks(self) -> None:
        self.mock_method_a = self.patch("example.main.method_a")
        self.mock_method_b = self.patch("example.main.method_b")

    def setUp(self) -> None:
        self.setup_mocks()

    def test_neither_is_true(self) -> None:
        self.mock_method_a.return_value = False
        self.mock_method_b.return_value = False
        self.assertEqual("neither are True", describe())

    def test_a_is_true(self) -> None:
        self.mock_method_a.return_value = True
        self.mock_method_b.return_value = False
        self.assertEqual("only A is True", describe())

    def test_b_is_true(self) -> None:
        self.mock_method_a.return_value = False
        self.mock_method_b.return_value = True
        self.assertEqual("only B is True", describe())

    def test_both_are_true(self) -> None:
        self.mock_method_a.return_value = True
        self.mock_method_b.return_value = True
        self.assertEqual("both are True", describe())


if __name__ == '__main__':
    unittest.main()
```

But we can still do better...


## Subtests!

Using subtests, we can define the values to test and how they are tested separately.

```python
import unittest
from collections import namedtuple
from unittest.mock import patch, MagicMock

from example.main import describe


class MyTestCase(unittest.TestCase):

    @patch("example.main.method_b")
    @patch("example.main.method_a")
    def test_describe(self, mock_method_a: MagicMock, mock_method_b: MagicMock) -> None:
        tc = namedtuple("TestCase", ["a", "b", "expected_value"])

        test_cases = [
            tc(False, False, "neither are True"),
            tc(False, True, "only B is True"),
            tc(True, False, "only A is True"),
            tc(True, True, "both are True"),
        ]

        for test_case in test_cases:
            with self.subTest(**test_case._asdict()):
                mock_method_a.return_value = test_case.a
                mock_method_b.return_value = test_case.b
                self.assertEqual(test_case.expected_value, describe())
                # sometimes wanna reset your mocks here, be careful


if __name__ == '__main__':
    unittest.main()
```

In my opinion, I like this better because I can squint past the `namedtuple` and sorta just see a table of:

| a | b | expected_value |
|---|---|----------------|
| `False` | `False` | `"neither are True"` |
| `False` | `True` | `"only B is True"` |
| `True` | `False` | `"only A is True"` |
| `True` | `True` | `"both are True"` |

...followed by a simple description of how each row in this table is tested.

### But if one case fails, how do you know which one failed?

Subtests are a delight; they basically show up as different tests:

![Subtest Execution](/assets/images/subtest_execution.png)

Our `**` unpacking is how it knows to say like `a=True`

## Caveats

As with many generalizations made in the name of DRYness, stop/revert if it gets too complicated. The goal is to make it easier to work with.

If you start adding conditionals in your subtest section, turn in the dumb version and go outside. ☀️