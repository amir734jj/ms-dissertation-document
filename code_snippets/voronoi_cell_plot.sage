from sage.modules.diamond_cutting import calculate_voronoi_cell

sub_dimension = 4 # reconciliation sub dimension

identity_matrix = Matrix.identity(RR, sub_dimension)    # create identity matrix
half_vector = [1/2 for i in range(sub_dimension)]       # construct 1/2 vector
identity_matrix[sub_dimension - 1] = half_vector        # modify last row of identity matrix
        
calculate_voronoi_cell(identity_matrix).translation(half_vector).show()  # create voronoi cell