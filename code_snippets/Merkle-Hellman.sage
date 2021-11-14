from sage.numerical.knapsack import Superincreasing
import random

MESSAGE_LEN = 24    # length of message (or superincreasing sequence)

def create_superincreasing_sequence(start, length): # this function creates superincreasing sequence
    sequence = []                                   # as described in Merkle-Hellman cryptosystem
    s = start
    val = start
    while length > 0:
        sequence.append(val)
        val = s + random.randrange(1, 10)           # add a random number between (0, 10)       
        s = s + val
        length = length - 1

    return sequence

# generate private-key
W = create_superincreasing_sequence(10, MESSAGE_LEN)
print "valid W: ", Superincreasing(W).is_superincreasing()  # validate W is superincreasing

q = next_prime(sum(W) + 1)  # generate a prime greater than sum of W
r = random.randint(1, q)    # random number between 1 inclusive and q exclusive

# generate public-key
beta = [(r * W[i]) % q for _ in range(len(W))]

# create dummy message
message = [random.randrange(10) % 2 for _ in range(MESSAGE_LEN)]

# generate ciphertext
ciphertext = sum([beta[i] * message[i] for _ in range(MESSAGE_LEN)])

# decrypt ciphertext
c_dash = (inverse_mod(r, q) * ciphertext) % q                        

# decompose c_dash using W
subset = Superincreasing(W).subset_sum(c_dash)                       

# testing the cryptosystem
reconstructed_message = []
for i in W:
    if i in subset:
        reconstructed_message.append(1)
    else:
        reconstructed_message.append(0)
    
print "message == decrypt(ciphertext): ", message == reconstructed_message # should print True

# breaking the cryptosystem
l = matrix.identity(MESSAGE_LEN + 1)    # create identity matrix of size n+1

# insert beta and ciphertext into matrix               
l.set_column(MESSAGE_LEN, beta + [-1 * ciphertext])

# reduce the lattice given basis matrix (or find the short vector in lattice)
l = l.LLL()

for i in range(l.nrows()):
# if row contains only {0, 1} then it might be a solution
    if all(x in [0, 1] for x in l.row(i)[:-1]):
        if l.row(i)[:-1].list() == message:
            print "Merkle-Hellman Knapsack Cryptosystem is broken!"