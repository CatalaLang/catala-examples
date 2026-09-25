# This is a template file following the expected interface and declarations to
# implement the corresponding Catala module.
#
# You should replace all `raise Impossible` place-holders with your
# implementation and rename it to remove the ".template" suffix.

from catala_runtime import *
from typing import Any, List, Callable, Tuple
from enum import Enum
from sys import stderr
from . import Stdlib_en as stdlib_en
from . import Date_en as date_en
from . import List_en as list_en
from . import Duration_en as duration_en
from . import MonthYear_en as month_year_en
from . import Period_en as period_en
from . import Money_en as money_en
from . import Integer_en as integer_en
from . import Decimal_en as decimal_en

import sqlite3

con = sqlite3.connect(":memory:")
cur = con.execute("CREATE TABLE lang(name, first_appeared)")

# This is the named style used with executemany():
data = (
    {"name": "C", "year": 1972},
    {"name": "Fortran", "year": 1957},
    {"name": "Python", "year": 1991},
    {"name": "Go", "year": 2009},
)
cur.executemany("INSERT INTO lang VALUES(:name, :year)", data)

import art

def fun(x:Integer) -> Integer:
    params = (1972,)
    cur.execute("SELECT * FROM lang WHERE first_appeared = ?", params)
    print(cur.fetchall())
    art.tprint("Catala", font="cybermedium")
    return Integer(0)

