from sage.crypto import gen_lattice
from sage.matrix.matrix_space import MatrixSpace
dimension = 16
modulus = random_prime(2^200, lbound=2^100) # setting upper / lower bound of
                                            # random prime generator
                                            
ring = GF(modulus) # Gaussian field modulo prime

# generate a random N x 1 matrix over the Finite Field
x = MatrixSpace(ring, dimension, 1).random_element()

# generate a random matrix and test if matrix forms a lattice 
# that is vectors are linearly independent
m = Matrix(gen_lattice(type="modular", m=dimension, q=modulus, lattice=True).basis())

print hex(int(list(sum(m * x)).pop()))
# e.g. output: 0x2baa49dd9e5d3daf27408f8c7cf049bc24075572c7e8bc3061L