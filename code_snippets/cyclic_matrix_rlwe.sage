modulus = 65537                                      # prime modulus
field = GF(modulus)                                  # number field
dimension = 1024                                     # dimension (resulting matrix is square)

def simple_wrapping_rule_random_matrix(row):
    result = [row]                                   # add first row to resulting matrix
    index = 0
    for _ in range(dimension - 1):                   # iterate (dimension - 1) times 
        row = result[index][:]                       # deep clone the previous row of matrix
        num = row.pop()                              # num <-- last element of previous row
        row.insert(0, modulus - num)                 # add (modulus - num) to the beginning of new row
        
        result.append(row)                           # append row to resulting matrix
            
        index = index + 1                            # increment row index
        
    return Matrix(result)                            # return resulting matrix

def quotient_ring_over_finite_field(row):
    result = [row]
    # Quotient polynomial ring over finite field
    R.<X> = PolynomialRing(field)                    # Gaussian field of integers
    Y.<x> = R.quotient(X^(dimension) + 1)            # Cyclotomic field
    index = 0
    for index in range(1, dimension):
        result.append( (Y(row) * x^index).list() )

    return Matrix(result)                            # return resulting matrix

  
row = random_matrix(field, dimension, 1).list()      # create random first row of matrix

# Test if quotient ring over finite field and simple wrapping rule generate the same matrix
print simple_wrapping_rule_random_matrix(row) ==  quotient_ring_over_finite_field(row)

# Test cumulative property of cyclic matrix
a = simple_wrapping_rule_random_matrix(random_matrix(field, dimension, 1).list())
b = simple_wrapping_rule_random_matrix(random_matrix(field, dimension, 1).list())

print a * b == b * a     # returns true if cumulative property exist