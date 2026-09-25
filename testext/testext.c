/* This is a template file following the expected interface and declarations to
 * implement the corresponding Catala module.
 *
 * You should replace all `catala_error(catala_impossible)` place-holders with
 * your implementation and rename it to remove the ".template" suffix. */

#include <stdio.h>
#include <stdlib.h>
#include <catala_runtime.h>

#include <Stdlib_en.h>
#include <Date_en.h>
#include <List_en.h>
#include <Duration_en.h>
#include <MonthYear_en.h>
#include <Period_en.h>
#include <Money_en.h>
#include <Integer_en.h>
#include <Decimal_en.h>

#include <sqlite3.h>

CATALA_INT Testext__fun (CATALA_INT x)
{
  CATALA_INT fun = catala_new_int(0);
  fprintf(stderr, "%s\n", sqlite3_libversion());
  return fun;
}

