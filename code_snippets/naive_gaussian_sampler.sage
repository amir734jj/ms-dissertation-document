import random

sigma = 8/sqrt(2 * pi)  # standard deviation
variance = sigma^2      # variance
mu = 0                  # mean (or center of distribution)

# probability density of the normal distribution
def pdf(x, sigma, variance, mu):
    return N((1 / sqrt(2 * variance * pi)) * e^(-(x - mu)^2 / (2 * variance)))

# note that sum of probabilities that this function generates is equal to 1/2
# because we are ignoring probabilities of negative numbers
def create_pdf_vector():
    pdf_vector = [0] * ceil(variance)
    
    for x in range(0, variance):
        pdf_vector[x] = pdf(x, sigma, variance, mu)
    
    return pdf_vector

# normalize probability list such that sum of probability would equal to 1
def normalize_pdf_vector(pdf_vector):
    s = sum(pdf_vector)
    return map((lambda x: x / s), pdf_vector)

# create cdf vector from pdf vector
def create_cdf_vector(pdf_vector):
    domain = len(pdf_vector)
    cdf_vector = [0] * domain
    total = 0
    
    for i in range(domain):
        total = total + pdf_vector[i]
        cdf_vector[i] = total
        
    return cdf_vector

# sample from cdf vector
def sample(cdf_vector):
    rand = random.uniform(0, 1)
    index = 0
    
    while(rand > cdf_vector[index]):
        index = index + 1
    
    return index

# create PDF vector and normalize it
pdf_vector = create_pdf_vector()
pdf_vector = normalize_pdf_vector(pdf_vector)

# create CDF vector from PDF vector
cdf_vector = create_cdf_vector(pdf_vector)

arr = [0] * len(pdf_vector)
for i in range(100000):    # count of samples
    s = sample(cdf_vector)
    arr[s] = arr[s] + 1

bar_chart(array)    # create bar char graph of samples