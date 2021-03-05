# Python

# Tips
## [考える]分岐をなくしたい
```python
# -*- coding: utf-8 -*-


from enum import Enum
from collections import namedtuple


class Conditions(Enum):
    A = ('A', lambda x: x)
    B = ('B', lambda x: x)
    C = ('C', lambda x: x)

    def __init__(self, tag, func):
        self.tag = tag
        self.func = func

    def exec(self) -> any:
        return self.func(self.tag)


class Strategy:
    @staticmethod
    def get_enum_by_namespace(tag):
        for value, member in Conditions.__members__.items():
            if tag == value:
                return member.exec()


def test():
    ret = namedtuple('ret', 'A B C')
    ls = []
    for tag in ['A', 'B', 'C']:
        ls.append(Strategy.get_enum_by_namespace(tag))
    return ret._make(ls)


if __name__ == '__main__':
    a, b, c = test()
```