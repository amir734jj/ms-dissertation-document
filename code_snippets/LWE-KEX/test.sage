shared = generate_polynomial()  # Shared matrix (A)

# Alice values
alice_secret = generate_error() # secret generated from error distribution
alice_error = generate_error()  
alice_value = shared * alice_secret + alice_error   # create R-LWE sample

# Bob values
bob_secret = generate_error()   # secret generated from error distribution
bob_error = generate_error()
bob_value = shared * bob_secret + bob_error         # create R-LWE sample

# Bob key
temp_error = generate_error()   # create secondary error and add it to calculated key to increase entropy
bob_key = alice_value * bob_secret + temp_error
w = generate_signal(bob_key)    # generate signal (or reconciliation bits) from Bob's key
bob_key_binary = reconcile(bob_key, w)

# Alice key
alice_key = bob_value * alice_secret                # no need to add secondary error
alice_key_binary = reconcile(alice_key, w)          # reconcile using Bob's reconciliation bits

if (alice_key_binary == bob_key_binary):
    print "Keys match!", hex(int(alice_key_binary, 2)) # print hex value of shared key if they match
else:
    print "Keys do not match!"