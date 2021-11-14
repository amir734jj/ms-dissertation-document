sub_dimension = 4 # reconciliation sub dimension

# helper function to convert from [c_0, c_1, ..., c_1023] to [(c_0, c_1, c_2, c_3), ..., (..., c_1023)]
def grouped(iterable, n):
	return zip(*[iter(iterable)]*n)

def initialize():
    identity_matrix = Matrix.identity(RR, sub_dimension)    # create identity matrix
    integer_lattice = IntegerLattice(identity_matrix)       # construct integer lattice from identity matrix
        
    half_vector = [1/2 for i in range(sub_dimension)]       # construct 1/2 vector
    identity_matrix[sub_dimension - 1] = half_vector        # modify last row of identity matrix
        
	main_polyhedron = calculate_voronoi_cell(identity_matrix).translation(half_vector)  # create voronoi cell
                                                                                        #  from modified matrix
	return (integer_lattice, main_polyhedron) # return integer lattice and polyhedron centered at

def dbl(coefficient_vector):    # add 1(2q) to all coefficients with probability 1/2
	return coefficient_vector + \
	vector( numpy.random.choice([0, 1], p=[0.5, 0.5]) * vector([1/(2*modulus) for _ in range(sub_dimension)]))

def generate_signal(poly):      # signal generation function
	coefficients = map(lambda x: RR(x) / modulus, poly.list())  # divide coefficient by modulus
	distances = []
	for v in grouped(coefficients, sub_dimension):
		v = dbl(vector(v))  # apply randomized double function
        # if point (or vector) is in main polyhedron then use center of main polyhedron else use lattice CVP
		if main_polyhedron.contains(vector(v)):
			distance = main_polyhedron.center() - v
		else:
			distance = integer_lattice.closest_vector(v) - v
		distances.append(distance)
	return distances

def reconcile(poly, w):         # reconcile using reconciliation information
	coefficients = map(lambda x: RR(x) / modulus, poly.list())  # divide coefficient by modulus
	key = []
	for difference, v in zip(w, grouped(coefficients, sub_dimension)):
		v = dbl(vector(v))  # apply randomized double function
		coordinate = vector([round(point, 1) for point in (v + difference) ]) # round point to 1 decimal point
		key.append(1 if coordinate == main_polyhedron.center() else 0)
	return "".join(map(str, key))

(integer_lattice, main_polyhedron) = initialize()
