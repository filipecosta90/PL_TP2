/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     id = 258,
     num = 259,
     string = 260,
     TYPE_INT = 261,
     TYPE_FUNCTION = 262,
     PL_IF = 263,
     PL_THEN = 264,
     PL_ELSE = 265,
     PL_DO = 266,
     PL_WHILE = 267,
     PL_PRINT = 268,
     PL_READ = 269,
     PL_CALL = 270,
     PL_RETURN = 271
   };
#endif
/* Tokens.  */
#define id 258
#define num 259
#define string 260
#define TYPE_INT 261
#define TYPE_FUNCTION 262
#define PL_IF 263
#define PL_THEN 264
#define PL_ELSE 265
#define PL_DO 266
#define PL_WHILE 267
#define PL_PRINT 268
#define PL_READ 269
#define PL_CALL 270
#define PL_RETURN 271




/* Copy the first part of user declarations.  */
#line 28 "algebric_cc.y"

#include <stdio.h>

typedef enum {PL_INTEGER, PL_ARRAY, PL_MATRIX, PL_FUNCTION} var_type;

typedef struct {
  char* varname;
  var_type type;
  int value;
  int** values;
  int size;
  int rows;
  int cols;
} datatype;

datatype var_table[1000];
int ia[1001];
int var_index = 0;

int closing_cycles_order[100];
int closing_conditionals_order[100];

int opened_cycles = 0;
int opened_conditionals = 0;

int number_cycles = 0;
int number_conditionals = 0;

int cycle_position_to_close = 0;
int conditional_position_to_close = 0;

void insert_int(char* varname);
void insert_array(char* varname, int size);
void insert_matrix(char* varname, int rows, int cols);
void insert_function ( char* function_name );

int open_cycle();
int close_cycle();
int open_conditional();
int close_conditional();
int current_conditional();
int lookup_int(char* varname);
int lookup_array(char* varname, int pos);
int get_matrix_ncols(char* varname);
int lookup_matrix(char* varname, int row, int col);
int exists_var(char* varname, var_type type);
int global_pos(char* varname);
int is_vector(char* varname);
int yylex();
int yyerror();
void compile_error( char* message);
void assert_no_redeclared_var( char* varname ,var_type type);
void assert_declared_var( char* varname, var_type type);



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 84 "algebric_cc.y"
{int qt; char* var;}
/* Line 193 of yacc.c.  */
#line 186 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 199 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   191

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  36
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  36
/* YYNRULES -- Number of rules.  */
#define YYNRULES  74
/* YYNRULES -- Number of states.  */
#define YYNSTATES  148

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   271

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    31,     2,     2,     2,    30,    33,     2,
      21,    22,    28,    26,    19,    27,     2,    29,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    17,
      35,    25,    34,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    18,     2,    20,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    23,    32,    24,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     4,     9,    13,    14,    17,    18,    21,
      29,    35,    36,    46,    51,    55,    58,    59,    62,    65,
      67,    69,    73,    77,    79,    81,    83,    84,    85,    93,
      96,    97,    99,   103,   105,   109,   113,   115,   119,   123,
     127,   129,   131,   133,   137,   140,   141,   144,   146,   151,
     156,   158,   163,   168,   172,   177,   181,   186,   190,   191,
     199,   200,   206,   207,   213,   218,   221,   222,   223,   233,
     234,   242,   245,   248,   251
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      37,     0,    -1,    -1,    39,    40,    38,    46,    -1,    39,
      41,    17,    -1,    -1,    40,    42,    -1,    -1,     6,     3,
      -1,     6,     3,    18,     4,    19,     4,    20,    -1,     6,
       3,    18,     4,    20,    -1,    -1,     7,     3,    21,    22,
      23,    43,    46,    45,    24,    -1,    15,     3,    21,    22,
      -1,    16,    56,    17,    -1,    46,    47,    -1,    -1,    48,
      17,    -1,    71,    17,    -1,    62,    -1,    68,    -1,     3,
      25,    49,    -1,    50,    25,    49,    -1,    56,    -1,    55,
      -1,    44,    -1,    -1,    -1,     3,    51,    18,    56,    52,
      53,    54,    -1,    19,    56,    -1,    -1,    20,    -1,    14,
      21,    22,    -1,    57,    -1,    56,    26,    57,    -1,    56,
      27,    57,    -1,    58,    -1,    57,    28,    58,    -1,    57,
      29,    58,    -1,    57,    30,    58,    -1,     4,    -1,     3,
      -1,    50,    -1,    21,    56,    22,    -1,    59,    60,    -1,
      -1,    31,    61,    -1,    61,    -1,    60,    32,    32,    61,
      -1,    60,    33,    33,    61,    -1,    56,    -1,    56,    25,
      25,    56,    -1,    56,    31,    25,    56,    -1,    56,    34,
      56,    -1,    56,    34,    25,    56,    -1,    56,    35,    56,
      -1,    56,    35,    25,    56,    -1,    21,    59,    22,    -1,
      -1,    65,     9,    23,    46,    24,    63,    67,    -1,    -1,
      65,     9,    47,    64,    67,    -1,    -1,    66,     8,    21,
      59,    22,    -1,    10,    23,    46,    24,    -1,    10,    47,
      -1,    -1,    -1,    11,    69,    23,    46,    24,    12,    21,
      59,    22,    -1,    -1,    11,    70,    47,    12,    21,    59,
      22,    -1,    13,     3,    -1,    13,    50,    -1,    13,     4,
      -1,    13,     5,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   108,   108,   107,   114,   115,   119,   120,   124,   129,
     134,   144,   143,   163,   172,   175,   176,   179,   180,   181,
     182,   185,   190,   197,   198,   199,   202,   216,   201,   227,
     228,   231,   238,   245,   246,   247,   250,   251,   252,   253,
     256,   258,   263,   264,   267,   268,   271,   280,   281,   289,
     299,   300,   304,   314,   318,   322,   326,   330,   335,   333,
     346,   344,   358,   358,   372,   378,   385,   392,   391,   406,
     405,   421,   430,   434,   439
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "id", "num", "string", "TYPE_INT",
  "TYPE_FUNCTION", "PL_IF", "PL_THEN", "PL_ELSE", "PL_DO", "PL_WHILE",
  "PL_PRINT", "PL_READ", "PL_CALL", "PL_RETURN", "';'", "'['", "','",
  "']'", "'('", "')'", "'{'", "'}'", "'='", "'+'", "'-'", "'*'", "'/'",
  "'%'", "'!'", "'|'", "'&'", "'>'", "'<'", "$accept", "AlgebricScript",
  "@1", "Declarations", "Function_Declarations", "Declaration",
  "Function_Declaration", "@2", "Function_Invocation", "Return_Statement",
  "Instructions", "Instruction", "Assignment", "Assignement_Value",
  "Vectors", "@3", "@4", "Second_Dimension", "Dimension_End", "Read_Stdin",
  "Arithmetic_Expression", "Term", "Factor", "Logical_Expressions",
  "Logical_Expression", "Relational_Expression", "Conditional", "@5", "@6",
  "If_Starter", "@7", "Else_Clause", "Cycle", "@8", "@9", "WriteStdout", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,    59,    91,    44,
      93,    40,    41,   123,   125,    61,    43,    45,    42,    47,
      37,    33,   124,    38,    62,    60
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    36,    38,    37,    39,    39,    40,    40,    41,    41,
      41,    43,    42,    44,    45,    46,    46,    47,    47,    47,
      47,    48,    48,    49,    49,    49,    51,    52,    50,    53,
      53,    54,    55,    56,    56,    56,    57,    57,    57,    57,
      58,    58,    58,    58,    59,    59,    60,    60,    60,    60,
      61,    61,    61,    61,    61,    61,    61,    61,    63,    62,
      64,    62,    66,    65,    67,    67,    67,    69,    68,    70,
      68,    71,    71,    71,    71
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     4,     3,     0,     2,     0,     2,     7,
       5,     0,     9,     4,     3,     2,     0,     2,     2,     1,
       1,     3,     3,     1,     1,     1,     0,     0,     7,     2,
       0,     1,     3,     1,     3,     3,     1,     3,     3,     3,
       1,     1,     1,     3,     2,     0,     2,     1,     4,     4,
       1,     4,     4,     3,     4,     3,     4,     3,     0,     7,
       0,     5,     0,     5,     4,     2,     0,     0,     9,     0,
       7,     2,     2,     2,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       5,     0,     7,     1,     0,     2,     0,     8,     0,    16,
       6,     4,     0,     0,     3,     0,     0,    26,    69,     0,
      15,     0,     0,    19,     0,     0,    20,     0,     0,    10,
       0,     0,     0,     0,    62,    26,    73,    74,    72,    17,
       0,    62,     0,    18,     0,    11,    41,    40,     0,     0,
       0,    25,    21,    42,    24,    23,    33,    36,     0,    16,
       0,    22,    16,    60,    45,     9,    16,     0,     0,     0,
       0,     0,     0,     0,     0,    27,    62,     0,    62,    66,
       0,    62,    32,     0,    43,    34,    35,    37,    38,    39,
      30,     0,    45,    58,    62,    61,    45,    63,     0,    50,
      44,    47,     0,     0,    13,     0,     0,     0,     0,    66,
      16,    65,     0,    46,     0,     0,     0,     0,     0,     0,
       0,    12,    29,    31,    28,    45,    70,    59,    62,    57,
       0,     0,     0,    53,     0,    55,     0,     0,    14,     0,
      64,    51,    52,    54,    56,    48,    49,    68
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     9,     2,     5,     6,    10,    66,    51,   103,
      14,    20,    21,    52,    53,    32,    90,   106,   124,    54,
      99,    56,    57,    80,   100,   101,    23,   109,    79,    24,
      25,    95,    26,    33,    34,    27
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -97
static const yytype_int16 yypact[] =
{
     -97,     9,    25,   -97,    35,    38,    39,    45,    69,   -97,
     -97,   -97,    90,    60,    79,    34,    61,    87,    97,   112,
     -97,    81,    99,   -97,   124,   141,   -97,   133,   147,   -97,
     129,   104,   135,   131,    10,   138,   -97,   -97,   -97,   -97,
     104,    82,   136,   -97,   139,   -97,   140,   -97,   142,   153,
      22,   -97,   -97,   -97,   -97,   109,   111,   -97,    22,   -97,
     148,   -97,   -97,   -97,   -97,   -97,   -97,   143,   145,     2,
      22,    22,    22,    22,    22,   109,    46,   146,    47,   151,
      11,   110,   -97,   149,   -97,   111,   111,   -97,   -97,   -97,
     150,   152,   -97,   -97,    88,   -97,    22,   -97,   106,   103,
     113,   -97,    22,   144,   -97,    22,   154,   155,    13,   151,
     -97,   -97,    15,   -97,   137,   156,    48,    75,   157,   158,
     105,   -97,   109,   -97,   -97,   -97,   -97,   -97,    73,   -97,
      22,    22,    22,   109,    22,   109,   106,   106,   -97,    44,
     -97,   109,   109,   109,   109,   -97,   -97,   -97
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -97,   -97,   -97,   -97,   -97,   -97,   -97,   -97,   -97,   -97,
     -55,   -33,   -97,   130,   -14,   -97,   -97,   -97,   -97,   -97,
     -28,    77,    70,   -86,   -97,   -96,   -97,   -97,   -97,   -97,
     -97,    63,   -97,   -97,   -97,   -97
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -72
static const yytype_int16 yytable[] =
{
      22,    60,   113,    55,    76,    38,   108,    78,    63,     3,
     112,    81,    55,    17,    46,    47,    46,    47,    46,    47,
      22,    18,    69,    19,    84,    46,    47,    22,    70,    71,
      75,     4,    96,    97,    96,   126,    96,   129,     7,   139,
     145,   146,    98,    50,    98,     8,    98,    46,    47,    17,
      17,    46,    47,    28,    29,   128,    11,    18,    18,    19,
      19,   111,    22,    12,    22,    96,   147,    22,    69,    50,
      91,    93,    13,   132,   120,    98,    17,   122,    46,    47,
      22,    16,    17,    30,    18,    17,    19,   -62,   133,   135,
      18,    17,    19,    18,    15,    19,    50,   140,    39,    18,
     134,    19,   141,   142,   143,    62,   144,    46,    47,    46,
      47,   110,    31,    17,    22,    35,    36,    37,    48,    49,
     -67,    18,   138,    19,    40,    50,   102,    96,   114,    70,
      71,    70,    71,    41,   115,    70,    71,   116,   117,    72,
      73,    74,    87,    88,    89,   118,   119,    85,    86,    42,
      43,    44,    45,    58,    59,   -71,    68,    64,   -26,    65,
      77,    94,   130,    67,   107,    82,    83,    92,   121,   105,
      61,   104,   127,     0,   123,     0,   125,     0,     0,     0,
       0,   131,     0,     0,     0,     0,     0,     0,     0,   136,
       0,   137
};

static const yytype_int16 yycheck[] =
{
      14,    34,    98,    31,    59,    19,    92,    62,    41,     0,
      96,    66,    40,     3,     3,     4,     3,     4,     3,     4,
      34,    11,    50,    13,    22,     3,     4,    41,    26,    27,
      58,     6,    21,    22,    21,    22,    21,    22,     3,   125,
     136,   137,    31,    21,    31,     7,    31,     3,     4,     3,
       3,     3,     4,    19,    20,   110,    17,    11,    11,    13,
      13,    94,    76,    18,    78,    21,    22,    81,    96,    21,
      24,    24,     3,    25,   102,    31,     3,   105,     3,     4,
      94,    21,     3,    22,    11,     3,    13,     8,   116,   117,
      11,     3,    13,    11,     4,    13,    21,    24,    17,    11,
      25,    13,   130,   131,   132,    23,   134,     3,     4,     3,
       4,    23,    25,     3,   128,     3,     4,     5,    14,    15,
      23,    11,    17,    13,    25,    21,    16,    21,    25,    26,
      27,    26,    27,     9,    31,    26,    27,    34,    35,    28,
      29,    30,    72,    73,    74,    32,    33,    70,    71,     8,
      17,     4,    23,    18,    23,    17,     3,    21,    18,    20,
      12,    10,    25,    21,    12,    22,    21,    21,    24,    19,
      40,    22,   109,    -1,    20,    -1,    21,    -1,    -1,    -1,
      -1,    25,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    32,
      -1,    33
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    37,    39,     0,     6,    40,    41,     3,     7,    38,
      42,    17,    18,     3,    46,     4,    21,     3,    11,    13,
      47,    48,    50,    62,    65,    66,    68,    71,    19,    20,
      22,    25,    51,    69,    70,     3,     4,     5,    50,    17,
      25,     9,     8,    17,     4,    23,     3,     4,    14,    15,
      21,    44,    49,    50,    55,    56,    57,    58,    18,    23,
      47,    49,    23,    47,    21,    20,    43,    21,     3,    56,
      26,    27,    28,    29,    30,    56,    46,    12,    46,    64,
      59,    46,    22,    21,    22,    57,    57,    58,    58,    58,
      52,    24,    21,    24,    10,    67,    21,    22,    31,    56,
      60,    61,    16,    45,    22,    19,    53,    12,    59,    63,
      23,    47,    59,    61,    25,    31,    34,    35,    32,    33,
      56,    24,    56,    20,    54,    21,    22,    67,    46,    22,
      25,    25,    25,    56,    25,    56,    32,    33,    17,    59,
      24,    56,    56,    56,    56,    61,    61,    22
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 108 "algebric_cc.y"
    { printf("start\n");}
    break;

  case 3:
#line 110 "algebric_cc.y"
    { printf("stop\n");}
    break;

  case 8:
#line 125 "algebric_cc.y"
    { 
               assert_no_redeclared_var((yyvsp[(2) - (2)].var),PL_INTEGER);
               insert_int((yyvsp[(2) - (2)].var)); 
             }
    break;

  case 9:
#line 130 "algebric_cc.y"
    { 
               assert_no_redeclared_var((yyvsp[(2) - (7)].var),PL_MATRIX);
               insert_matrix((yyvsp[(2) - (7)].var),(yyvsp[(4) - (7)].qt),(yyvsp[(6) - (7)].qt)); 
             }
    break;

  case 10:
#line 135 "algebric_cc.y"
    { 
               assert_no_redeclared_var((yyvsp[(2) - (5)].var),PL_ARRAY);
               insert_array((yyvsp[(2) - (5)].var), (yyvsp[(4) - (5)].qt)); 
             }
    break;

  case 11:
#line 144 "algebric_cc.y"
    {
                       assert_no_redeclared_var((yyvsp[(2) - (5)].var),PL_FUNCTION);
                       printf("\t\t\t\t\t\t// +++ Function Declaration Start +++\n");
                       insert_function((yyvsp[(2) - (5)].var));
                       printf("\t\tjump endfunction%s\n",(yyvsp[(2) - (5)].var));
                       printf("startfunction%s:\n",(yyvsp[(2) - (5)].var));
                       printf("\t\tnop\t\t// no operation\n");
                     }
    break;

  case 12:
#line 154 "algebric_cc.y"
    {
                       printf("\t\tstoreg %d\t// store returned value of  %s\n",global_pos((yyvsp[(2) - (9)].var)),(yyvsp[(2) - (9)].var));
                       printf("\t\treturn\n");
                       printf("endfunction%s:\n",(yyvsp[(2) - (9)].var));
                       printf("\t\t\t\t\t\t// --- Function Declaration End ---\n");
                     }
    break;

  case 13:
#line 164 "algebric_cc.y"
    { 
                      assert_declared_var((yyvsp[(2) - (4)].var),PL_FUNCTION);
                      printf("\t\tpusha startfunction%s\n",(yyvsp[(2) - (4)].var));
                      printf("\t\tcall\n");
                      printf("\t\tpushg %d\t// pushes returned value of  %s\n",global_pos((yyvsp[(2) - (4)].var)),(yyvsp[(2) - (4)].var));
                    }
    break;

  case 21:
#line 186 "algebric_cc.y"
    {
             assert_declared_var((yyvsp[(1) - (3)].var), PL_INTEGER );
             printf("\t\tstoreg %d\t// store var %s\n",global_pos((yyvsp[(1) - (3)].var)),(yyvsp[(1) - (3)].var));
           }
    break;

  case 22:
#line 192 "algebric_cc.y"
    {
             printf("\t\tstoren\n");
           }
    break;

  case 26:
#line 202 "algebric_cc.y"
    { 
        if ( is_vector((yyvsp[(1) - (1)].var)) ){
          assert_declared_var((yyvsp[(1) - (1)].var),PL_ARRAY);
        }
        else{
          assert_declared_var((yyvsp[(1) - (1)].var),PL_MATRIX);
        }
          printf("\t\tpushgp\n");
          printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos((yyvsp[(1) - (1)].var)),(yyvsp[(1) - (1)].var) ); 
          printf("\t\tpadd\n");
          printf("\t\t\t\t\t\t// +++ Matrix or Vector Dimension Start +++\n");
        }
    break;

  case 27:
#line 216 "algebric_cc.y"
    {
        if ( is_vector((yyvsp[(1) - (4)].var)) ){
        }
        else {
          printf("\t\tpushi %d\t\t\t\t//pushes column size of vector or matrix\n",get_matrix_ncols((yyvsp[(1) - (4)].var)));
          printf("\t\tmul\n");
        }
        }
    break;

  case 30:
#line 228 "algebric_cc.y"
    {printf("\t\tpushi 0\t\t//second dimension size of vector(0)\n");}
    break;

  case 31:
#line 232 "algebric_cc.y"
    {
                printf("\t\tadd\t\t//sums both dimensions\n");
                printf("\t\t\t\t\t\t// --- Matrix or Vector Dimension End ---\n");
              }
    break;

  case 32:
#line 239 "algebric_cc.y"
    {
             printf("\t\tread\n");
             printf("\t\tatoi\n");  
           }
    break;

  case 34:
#line 246 "algebric_cc.y"
    { printf("\t\tadd\n");}
    break;

  case 35:
#line 247 "algebric_cc.y"
    { printf("\t\tsub\n");}
    break;

  case 37:
#line 251 "algebric_cc.y"
    { printf("\t\tmul\n");}
    break;

  case 38:
#line 252 "algebric_cc.y"
    { printf("\t\tdiv\n");}
    break;

  case 39:
#line 253 "algebric_cc.y"
    { printf("\t\tmod\n");}
    break;

  case 40:
#line 257 "algebric_cc.y"
    { printf("\t\tpushi %d\n", (yyvsp[(1) - (1)].qt)); }
    break;

  case 41:
#line 259 "algebric_cc.y"
    {
          assert_declared_var((yyvsp[(1) - (1)].var), PL_INTEGER);
          printf("\t\tpushg %d\n", global_pos((yyvsp[(1) - (1)].var)));
        }
    break;

  case 42:
#line 263 "algebric_cc.y"
    { printf("\t\tloadn \n");}
    break;

  case 46:
#line 272 "algebric_cc.y"
    {
                     printf("\t\t\t\t\t\t// +++ Logical NOT BEGIN +++\n");
                     printf("\t\tpushi 1\n");
                     printf("\t\tadd\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Logical NOT END ---\n");
                   }
    break;

  case 48:
#line 282 "algebric_cc.y"
    {
                     printf("\t\t\t\t\t\t// +++ Logical OR BEGIN +++\n");
                     printf("\t\tadd\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Logical OR END ---\n");
                   }
    break;

  case 49:
#line 290 "algebric_cc.y"
    {
                     printf("\t\t\t\t\t\t// +++ Logical AND BEGIN +++\n");
                     printf("\t\tmul\n");
                     printf("\t\tpushi 2\n");
                     printf("\t\tmod\n");
                     printf("\t\t\t\t\t\t// --- Logical AND END ---\n");
                   }
    break;

  case 51:
#line 301 "algebric_cc.y"
    {
                        printf("\t\tequal\t//relational equal\n");
                      }
    break;

  case 52:
#line 305 "algebric_cc.y"
    {
                        printf("\t\t\t\t\t\t// +++ Logical NOT EQUAL BEGIN +++\n");
                        printf("\t\tequal\n");
                        printf("\t\tpushi 1\n");
                        printf("\t\tadd\n");
                        printf("\t\tpushi 2\n");
                        printf("\t\tmod\n");
                        printf("\t\t\t\t\t\t// --- Logical NOT EQUAL END ---\n");
                      }
    break;

  case 53:
#line 315 "algebric_cc.y"
    {
                        printf("\t\tsup\t//relational superior\n");
                      }
    break;

  case 54:
#line 319 "algebric_cc.y"
    {
                        printf("\t\tsupeq\t//relational superior or equal\n");
                      }
    break;

  case 55:
#line 323 "algebric_cc.y"
    {
                        printf("\t\tinf\t//relational inferior\n");
                      }
    break;

  case 56:
#line 327 "algebric_cc.y"
    {
                        printf("\t\tinfeq\t//relational inferior or equal\n");
                      }
    break;

  case 58:
#line 335 "algebric_cc.y"
    {
              int conditional_id = current_conditional();
              printf("\t\tjump outif%d\n",conditional_id); 
              printf("inelse%d:\n",conditional_id);
            }
    break;

  case 59:
#line 341 "algebric_cc.y"
    {
              printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
            }
    break;

  case 60:
#line 346 "algebric_cc.y"
    {
              int conditional_id = current_conditional();
              printf("\t\tjump outif%d\n",conditional_id); 
              printf("inelse%d:\n",conditional_id);
            }
    break;

  case 61:
#line 352 "algebric_cc.y"
    {
              printf("\t\t\t\t\t\t// --- CONDITIONAL IF END ---\n");
            }
    break;

  case 62:
#line 358 "algebric_cc.y"
    {
             int conditional_id = open_conditional();
             printf("\t\t\t\t\t\t// +++ CONDITIONAL IF BEGIN +++\n");
             printf("conditional%d:\n",conditional_id);
           }
    break;

  case 63:
#line 365 "algebric_cc.y"
    {
             int conditional_id = current_conditional();
             printf("\t\tjz inelse%d\n",conditional_id); 
             printf("inthen%d:\n",conditional_id);
           }
    break;

  case 64:
#line 374 "algebric_cc.y"
    {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
    break;

  case 65:
#line 380 "algebric_cc.y"
    {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
    break;

  case 66:
#line 385 "algebric_cc.y"
    {
              int conditional_closed = close_conditional();
              printf("outif%d:\n",conditional_closed);
            }
    break;

  case 67:
#line 392 "algebric_cc.y"
    {
        int cycle_id = open_cycle();
        printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
        printf("cycle%d:\t//do\n",cycle_id);
      }
    break;

  case 68:
#line 398 "algebric_cc.y"
    {
        int cycle_closed = close_cycle();
        printf("\t\tjz endcycle%d\t//while\n",cycle_closed);
        printf("\t\tjump cycle%d\n",cycle_closed);
        printf("endcycle%d:\n",cycle_closed);
        printf("\t\t\t\t\t\t// --- CICLE DO END ---\n");
      }
    break;

  case 69:
#line 406 "algebric_cc.y"
    {
        int cycle_id = open_cycle();
        printf("\t\t\t\t\t\t// +++ CICLE DO BEGIN +++\n");
        printf("cycle%d:\t//do\n",cycle_id);
      }
    break;

  case 70:
#line 412 "algebric_cc.y"
    {
        int cycle_closed = close_cycle();
        printf("\t\tjz endcycle%d\t//while\n",cycle_closed);
        printf("\t\tjump cycle%d\n",cycle_closed);
        printf("endcycle%d:\n",cycle_closed);
        printf("\t\t\t\t\t\t// --- CICLE DO END ---\n");
      }
    break;

  case 71:
#line 422 "algebric_cc.y"
    {
              printf("\t\tpushgp\n");
              assert_declared_var((yyvsp[(2) - (2)].var), PL_INTEGER);
              printf("\t\tpushi %d\t//puts on stack the address of %s\n",global_pos((yyvsp[(2) - (2)].var)),(yyvsp[(2) - (2)].var) ); 
              printf("\t\tpadd\n");
              printf("\t\tpushi 0\n");
              printf("\t\tloadn\n\t\twritei\n");
            }
    break;

  case 72:
#line 431 "algebric_cc.y"
    {
              printf("\t\tloadn\n\t\twritei\n");
            }
    break;

  case 73:
#line 435 "algebric_cc.y"
    { 
              printf("\t\tpushi %di\t//print num %d\n",(yyvsp[(2) - (2)].qt),(yyvsp[(2) - (2)].qt)); 
              printf("\t\twritei\n"); 
            }
    break;

  case 74:
#line 440 "algebric_cc.y"
    { 
              printf("\t\tpushs %s\t//print string %s\n",(yyvsp[(2) - (2)].var),(yyvsp[(2) - (2)].var)); 
              printf("\t\twrites\n"); 
            }
    break;


/* Line 1267 of yacc.c.  */
#line 1936 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 445 "algebric_cc.y"


#include "lex.yy.c"

int open_cycle(){
    int cycle = number_cycles;
    closing_cycles_order[cycle_position_to_close+1] = cycle;
    number_cycles++;
    cycle_position_to_close++;
    return cycle;
}

int close_cycle(){
    int cycle_to_close = closing_cycles_order[cycle_position_to_close];
    cycle_position_to_close--;
    return cycle_to_close;
}

int open_conditional(){
    int conditional = number_conditionals;
    closing_conditionals_order[conditional_position_to_close+1] = conditional;
    number_conditionals++;
    conditional_position_to_close++;
    return conditional;
}

int current_conditional(){
    int actual_conditional = closing_conditionals_order[conditional_position_to_close];
    return actual_conditional;
}

int close_conditional(){
    int conditional_to_close = closing_conditionals_order[conditional_position_to_close];
    conditional_position_to_close--;
    return conditional_to_close;
}

void insert_int ( char* varname ) {
    var_table[var_index].varname = strdup(varname);
    var_table[var_index].value = 0;
    var_table[var_index].type = PL_INTEGER;
    var_table[var_index].size =1;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + 1;
    printf("\t\tpushi 0\t//%s\n",varname);
}

void insert_array ( char* varname, int size ) {
    var_table[var_index].varname = strdup(varname);
    var_table[var_index].value = 0;
    var_table[var_index].type = PL_ARRAY;
    var_table[var_index].size =size;
    var_table[var_index].cols = size;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + size;
    printf("\t\tpushn %d\t//%s[%d]\n",size,varname,size);
}

void insert_matrix ( char* varname, int rows, int cols ) {
    var_table[var_index].varname = strdup(varname);
    var_table[var_index].value = 0;
    var_table[var_index].type = PL_MATRIX;
    var_table[var_index].rows = rows;
    var_table[var_index].cols = cols;
    int size = rows * cols;
    var_table[var_index].size =size;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + size;
    printf("\t\tpushn %d\t//%s[%d][%d] (size %d)\n",size,varname,rows,cols,size);
}

void insert_function ( char* function_name ) {
    var_table[var_index].varname = strdup( function_name );
    var_table[var_index].value = -1;
    var_table[var_index].type = PL_FUNCTION;
    var_table[var_index].rows = -1;
    var_table[var_index].cols = -1;
    var_table[var_index].size =-1;
    int old_size = ia[var_index];
    var_index++;
    ia[var_index] = old_size + 1;
    printf("\t\tpushi 0\t\t// space for fucntion %s returned value\n", function_name);
}

int exists_var(char* varname, var_type type) {
    int i, r;
    i = 0;
    while (( i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)) {
        i++;
    }
    
    if ( i == var_index ) {
        r = 0;
    }
    else {
        if (type == var_table[i].type) {
            r = 1;
        }
    }
    return r;
}

int is_vector(char* varname) {
    int i, r;
    i = 0;
    while (( i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)) i++;
    if ( i == var_index ) {
        r = 0;
    }
    else {
        if( var_table[i].type == PL_ARRAY ){
            r = 1;
        }
        else{
            r = 0;
        }
    }
    return r;
}

int global_pos(char* varname) {
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = ia[i];
    }
    return result;
}

int lookup_int(char* varname) {
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = var_table[i].value;
    }
    return result;
}

int lookup_array(char* varname, int pos) {
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = (var_table[i].values)[1][pos];
    }
    return result;
}

int get_matrix_ncols(char* varname){
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = var_table[i].cols;
    }
    return result;
}

void compile_error( char* message){
    yyerror(message);
    exit(0);
}
void assert_no_redeclared_var( char* varname ,var_type type){
    if ( exists_var(varname, type) ){
        compile_error("re-declaring VAR");
    }
}

void assert_declared_var(char* varname, var_type type){
    if ( !exists_var(varname, type) ){
        compile_error("accessing non declared VAR");
    }
}

int lookup_matrix(char* varname, int row, int col) {
    int i, result;
    i = 0;
    while( (i < var_index ) && (strcmp(var_table[i].varname, varname)!= 0)){ i++; }
    if ( i == var_index ) {
        result = -1;
    }
    else{
        result = (var_table[i].values)[row][col];
    }
    return result;
}

int yyerror(char* s) {
    if (strlen(yytext)>1){
        printf("\t\terr \"Error (input file line %d): %s at %s\"\n", yylineno, s, yytext);
        fprintf(stderr,"Error\t (line %d): %s at %s\n", yylineno, s, yytext);
    }
    else {
        printf("\t\terr \"Error (input file line %d): %s\"\n", yylineno, s);
        fprintf(stderr,"Error\t (line %d): %s\n", yylineno, s);
    }
    return 1;
}

int main () {
    yyparse();
    return 0;
}

