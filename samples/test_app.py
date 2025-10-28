"""
Quick sanity file to test keymaps and LSP/completion behavior.

Try:
- <Tab>/<S-Tab> in insert mode to accept completion or indent/unindent.
- <Tab>/<S-Tab> in normal/visual to indent/unindent.
- Flash with `s`, references with `(`/`)`, and `%` alternative `gs`.
- LSP: hover on symbols (K), code actions (<leader>la), rename (<leader>rn).
"""

import sys  # unused: triggers code action/formatters to suggest removal
import math

from typing import List


def greet(name: str) -> str:
    return f"Hello, {name}!"  # long-ish line fine for formatters


def sum_numbers(nums: List[int]) -> int:
    total = 0
    for n in nums:
        total += n
    return total


class Box:
    def __init__(self, width: int, height: int) -> None:
        self.width = width
        self.height = height

    def area(self) -> int:
        return self.width * self.height


def main() -> None:
    name = "World"
    print(greet(name))

    nums = [1, 2, 3, 4]  # select and try <leader>i / <leader>I
    print("sum:", sum_numbers(nums))

    box = Box(3, 5)
    print("area:", box.area())

    # parentheses/brackets/braces test for `gs` / `%`
    nested = {"a": [1, (2, 3), {"k": (4, 5)}]}
    print("nested:", nested)


if __name__ == "__main__":
    main()

