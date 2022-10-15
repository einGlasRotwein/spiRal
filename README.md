
# spiRal

Creates a matrix where 1 is the center, with numbers spiraling to the outside.

## It's working, thanks

A friend sent me the [following picture](https://aprogrammerlife.com/images/pictuers/yes_its_working.jpg) she found on some programmer's humor website:

<p align="center">
  <img src="https://github.com/einGlasRotwein/spiRal/blob/main/yes_its_working.jpg?raw=true" width="350">
</p>

(I only have the link and I'm not sure where it originated; I saved a copy of it in this repo in case original link breaks at some point.)

It's funny and all, but I immediately wanted to try and write a function that **actually** solves the problem.
Of course, it's not really a coding problem, but more of a logic puzzle where you have to identify the pattern (and then express it in code).
I am sure that a very simple solution for the problem exists that solves it with a few lines of code (and a good understanding of math), but I wanted to find a solution without the help of Google or StackOverflow.

After a little while, I had a working solution that scales with different maximum numbers (not only 25, as in the example) and can handle situations where the final matrix doesn't have symmetric dimensions (i.e., with a maximum number of 13).
So now it's time to look into how it's **actually** done (I bet there's a math video somewhere on YouTube about it), but in the mean time, here's my code.
It ain't pretty, but it works.

## Spirals

I've put the spiral function into a tiny package, which you can install:

```
library("devtools") # if not available: install.packages("devtools")
install_github("einGlasRotwein/spiRal")

# load the package via
library("spiRal")
```

This will create a spiral with the number 1 - 9 (spirals always start at 1) in 
a 3 x 3 matrix.

```
spiral(9)
#      [,1] [,2] [,3]
# [1,]    7    8    9
# [2,]    6    1    2
# [3,]    5    4    3
```

If the spiral doesn't fit into a square matrix (e.g., 3 x 3 or 4 x 4), missing 
spots will be filled with NAs.

```
spiral(10)
#      [,1] [,2] [,3] [,4]
# [1,]    7    8    9   10
# [2,]    6    1    2   NA
# [3,]    5    4    3   NA
```

Of course, larger spirals are also possible:

```
# spiral(111)
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
#  [1,]  111   NA   NA   NA   NA   NA   NA   NA   NA    NA    NA
#  [2,]  110   73   74   75   76   77   78   79   80    81    82
#  [3,]  109   72   43   44   45   46   47   48   49    50    83
#  [4,]  108   71   42   21   22   23   24   25   26    51    84
#  [5,]  107   70   41   20    7    8    9   10   27    52    85
#  [6,]  106   69   40   19    6    1    2   11   28    53    86
#  [7,]  105   68   39   18    5    4    3   12   29    54    87
#  [8,]  104   67   38   17   16   15   14   13   30    55    88
#  [9,]  103   66   37   36   35   34   33   32   31    56    89
# [10,]  102   65   64   63   62   61   60   59   58    57    90
# [11,]  101  100   99   98   97   96   95   94   93    92    91
```

(At some point, they take up quite some space in the console, though).
