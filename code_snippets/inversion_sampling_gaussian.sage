import random

# return pdf(x) = standard Gaussian pdf
def pdf(x):
    return e^(-x * x / 2) / sqrt(2 * pi)

# return pdf(x, mu, signma) = Gaussian pdf with mean mu and stddev sigma
def pdf_init(x, mu, sigma):
    return pdf((x - mu) / sigma) / sigma
    
# return cdf(z) = standard Gaussian cdf using Taylor approximation
def cdf(z, variance):
    if z < -variance:
        return 0.0
    if z > variance:
        return 1.0
    sum = 0.0
    term = z
    i = 3
    while sum + term != sum:
        sum = sum + term
        term = term * z * z / i
        i += 2
    return 0.5 + sum * pdf(z)

# return cdf(z, mu, sigma) = Gaussian cdf with mean mu and stddev sigma
def cdf_init(z, mu, sigma):
    return cdf((z - mu) / sigma)

# Compute z such that cdf(z) = y via bisection search
def inverse_CDF_init(y, variance):
    return inverse_CDF(y, 0.00000001, -variance, variance, variance)

# bisection search
def inverse_CDF(y, delta, lo, hi, variance):
    mid = lo + (hi - lo) / 2
    if hi - lo < delta:
        return mid
    if cdf(mid, variance) > y:
        return inverse_CDF(y, delta, lo, mid, variance)
    else:
        return inverse_CDF(y, delta, mid, hi, variance)
       

sigma = 8/sqrt(2 * pi)   # standard deviation
variance = ceil(sigma^2) # variance
array = [0] * variance * 2

for i in range(300):   # count of samples
    sample = round(inverse_CDF_init(random.uniform(0, 1), variance) * sigma)
    array[variance + sample] += 1
    
bar_chart(array).show()