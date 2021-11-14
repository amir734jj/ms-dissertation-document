import random, hashlib, sha3

shake_block_size = 16                       # by default SHA-3 block size is 16 bits 

dimension = count_of_coefficients = 1024    # degree of polynomials
modulus = 12289                             # modulus

# Quotient polynomial ring
R.<X> = PolynomialRing(GF(modulus))         # Gaussian field of integers
Y.<x> = R.quotient(X^(dimension) + 1)       # Cyclotomic field

# seed should be {0, ..., 255}^32 or 8 X 32 = 256 bit uniformly random number
seed = random.getrandbits(8 * 32)

# calculate hex digest of seed
digest = sha3.shake_128(str(seed)).hexdigest(int(2 * count_of_coefficients))

# fill the binary representation with zero so '110' becomes '0110' 
b = str(bin(int(digest, 16)))[2:].zfill(count_of_coefficients * shake_block_size)

# convert list to chunks of size = shake_block_size
chunks = [int(b[i:i+shake_block_size], 2) for i in range(0, len(b), shake_block_size)]

# reduce chunks to modulu 2^14 by setting two most significant bits to zero
chunks = map((lambda x: x ^^ 0xC000), chunks)

# if chunk is less than modulus then keep it else reject it
chunks = map((lambda x: x if x < modulus else 0), chunks)

# convert list of coefficients to polynomial modulo
uniform_a = Y(chunks)

print uniform_a     # print the resulting polynomial