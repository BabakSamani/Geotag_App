package utility;

/**
 * Created by IntelliJ IDEA.
 * User: Milan Vít (Cellane)
 * Date: May 13, 2010
 * Time: 1:10:02 PM
 */

public class MatrixInversion {
	/**
	 * Main method that initializes the matrix and calls method to calculate
	 * inverted matrix of given matrix 
	 *
	 * @param args command line arguments; unused
	 */
	public static void main (String[] args) {
		double matrix[][] = {
				{100, 100, 100,},
				{-100, 300, -100,},
				{-100, -100, 300,},
		};

		double invertedMatrix[][] = MatrixOperations.invertMatrix (matrix);

		MatrixOperations.printMatrix (invertedMatrix, 4);
	}
}
