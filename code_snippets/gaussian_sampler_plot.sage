sigma = 8 / sqrt(2 * pi)
offset = 20  # offset for plotting purposes, shift center to 20 instead of zero
size = 2^20  # count of samples   
data = [0] * 50

T = RealDistribution('gaussian', sigma)

for i in range(size):
    num = int(T.get_random_element())
    data[num + offset] = data[num + offset] + 1

b = bar_chart(data)
plot(b)