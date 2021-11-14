import random

# generate n bit uniformly random number
def random_bit(bit_len):
    return random.getrandbits(bit_len)

# sample two numbers and return their difference    
def sample(bit_len):
    b_1 = random_bit(bit_len)
    b_2 = random_bit(bit_len)
        
    return int(b_1 - b_2)

# initialize a histogram, shifting is only for visualization purposes   
bit_len = 8
dist = [0] * 2^bit_len * 2 * 2
offset = 2^bit_len

for i in range(100000): # number of samples
    s = sample(bit_len)
    dist[s +  offset] = dist[s + offset] + 1
    
bar_chart(dist).show()