temp_modulus = (2 * modulus) if is_odd(modulus) else modulus    # if modulus is odd then multiply it by 2
temp = temp_modulus / 8                 # q/8
value_1 = temp + (temp_modulus / 4)     # q/8 + q/4
value_2 = temp + (3 * temp_modulus / 4) # q/8 + 3q/4 
value_3 = temp                          # q/8    
value_4 = temp + (temp_modulus / 2)     # q/8 + q/2

# randomized double function, notice probability of 0 => 0.5
def dbl(coefficient):
    return  ( 2 * int( coefficient ) - numpy.random.choice([-1, 0, 1], p=[0.25, 0.5, 0.25]) ) % temp_modulus

def generate_signal(poly):
    coefficients = map(dbl, poly.list())    # apply dbl function to all coefficient
    signal = []
    for coefficient in coefficients:
        # if coefficient [0, q/4] OR [q/2, 3q/4] then signal bit = 1 else 0
        if (coefficient) <= (temp_modulus / 4) or \
            ((coefficient) <= (3 * temp_modulus / 4) and (coefficient) >= (temp_modulus / 2)):
            signal.append(1)
        else:
            signal.append(0)
    return signal 

def reconcile(poly, w):
    coefficients = map(dbl, poly.list())    # apply dbl function to all coefficient
    key = []
    # use signal bit to reconcile
    for coefficient, bit in zip(coefficients, w):        
        if bit == 1:
            key.append(1 if coefficient >= value_1 and coefficient <= value_2 else 0)
        else:
            key.append(1 if coefficient >= value_3 and coefficient <= value_4 else 0)
    return "".join(map(str, key))