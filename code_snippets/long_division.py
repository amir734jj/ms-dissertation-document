from itertools import izip
from math import fabs

def multiply(a, b):
    r = [0] * (len(a) + len(b) - 1)
    for i in range(len(a)):
        for j in range(len(b)):
            r[i + j] += a[i] * a[j]
    return r

def degree(poly):
    while poly and poly[-1] == 0:
        poly.pop()  # normalize
    return len(poly) - 1

def division(N, D):
    dD = degree(D)
    dN = degree(N)
    if dD < 0: raise ZeroDivisionError
    if dN >= dD:
        q = [0] * dN
        while dN >= dD:
            d = [0] * (dN - dD) + D
            mult = q[dN - dD] = N[-1] / float(d[-1])
            d = [coeff * mult for coeff in d]
            N = [fabs(coeffN - coeffd) for coeffN, coeffd in izip(N, d)]
            dN = degree(N)
        r = N
    else:
        q = [0]
        r = N
    return q, r

N = [-42, 0, -12, 1]
D = [-3, 1, 0, 0]
print "  %s / %s =" % (N, D),
print "quotient %s remainder %s" % division(N, D)
print "multipication result %s" % multiply(N, D)

#   [-42, 0, -12, 1] / [-3, 1, 0, 0] = quotient [27.0, 9.0, 1.0] remainder [123.0]
# multipication result [1764, 0, 504, -42, 0]
