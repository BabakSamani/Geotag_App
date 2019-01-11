package utility;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

public class MLPQ {
	private static Vector2D limitsMax = new Vector2D(-10000000, -10000000);
	private static Vector2D limitsMin = new Vector2D(10000000, 10000000);
	private static double scaleTo = 0;
	private static double xOffset = 0;
	private static double yOffset = 0;

	public MLPQ() {
		super();
	}
	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void Coordinate2MLPQ(ArrayList<String> coor) throws IOException {
		// Input the latitudes and longitude here
//		ArrayList<String> coor = new ArrayList<String>(
//				Arrays.asList("41.44272637767213,101.49169921875", "41.83682786072715,101.898193359375",
//						"42.22038178372061,101.79931640625", "42.44778143462245,101.458740234375",
//						"42.53689200787315,100.83251953125", "41.97582726102573,100.360107421875",
//						"41.50857729743936,100.56884765625", "41.30257109430558,101.05224609375"));

		int sizeOfDataPoint = coor.size();
		double[] lats = new double[sizeOfDataPoint];
		double[] lons = new double[sizeOfDataPoint];

		// feed the lats and lons with the datapoint arraylist
		int counter = 0;
		for (String s : coor) {
			int commaIndex = s.indexOf(",");
			lats[counter] = Double.parseDouble(s.substring(0, commaIndex));
			lons[counter] = Double.parseDouble(s.substring(commaIndex + 1, s.length()));
			counter++;
		}

		// from Matlab
		// double[] lats = { 0.251083857976031, 0.616044676146639, 0.473288848902729,
		// 0.351659507062997, 0.830828627896291,
		// 0.585264091152724 };
		// double[] lons = { 0.549723608291140, 0.917193663829810, 0.285839018820374,
		// 0.757200229110721, 0.753729094278495,
		// 0.380445846975357 };
		// int sizeOfDataPoint = 6;

		for (int i = 0; i < sizeOfDataPoint; i++)
			// System.out.println(lats[i]);
			System.out.println(lons[i]);

		// Create vector of points (each point is a in vector2D format)
		Vector<Vector2D> pointSet = new Vector<Vector2D>();

		// create points, add them to the pointSet, and put the max and min of them into
		// a vector
		int pointSize = lats.length;
		for (int i = 0; i < pointSize; i++) {
			pointSet.add(new Vector2D(lats[i], lons[i]));
			if (limitsMax.x < lats[i])
				limitsMax.x = lats[i];
			if (limitsMin.x > lats[i])
				limitsMin.x = lats[i];
			if (limitsMax.y < lons[i])
				limitsMax.y = lons[i];
			if (limitsMin.y > lons[i])
				limitsMin.y = lons[i];
		}

		// create delaunay triangles
		try {
			DelaunayTriangulator delaunayTriangulator = new DelaunayTriangulator(pointSet);
			delaunayTriangulator.triangulate();
			// put all the delaunay triangles in tR list
			List<Triangle2D> tR = delaunayTriangulator.getTriangles();

			// put all the triangles' circum centers into cC arraylist
			/*
			 * ArrayList<Vector2D> cC=new ArrayList<Vector2D>(); for (Triangle2D tA:tR)
			 * cC.add(tA.getCircumCenter());
			 */

			// write into a file
			writeTriangleforMLPQ(tR, "MLPQresult");
			// draw triangles in a pdf file
//			printTriangles(tR);

			System.out.print(tR.toString());

		} catch (NotEnoughPointsException e) {
			System.out.println(e);
		}

	}

	static void writeTriangleforMLPQ(List<Triangle2D> tR2, String fileName) {
		String FileName = "/Users/babak/OneDrive - University of Nebraska-Lincoln/Courses/CSCE813/Project/Web_App/Geotag_App/WebContent/MLPQresult/" + fileName + ".html";
		//String FileName = "/Users/babak/Documents/" + fileName + ".html";
		File Fileright = new File(FileName);
		Fileright.getParentFile().mkdirs();
		PrintWriter pw = null;
		try {
			pw = new PrintWriter(Fileright);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		pw.print("<html>");
		pw.print("<head>");
		pw.print("<title>MPLQ Result</title>");
		pw.print("<meta contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\" >");
		pw.print("</head>");
		pw.print("<body>");
		pw.println("begin %MLPQ% <br>");
		// x and y coordinates of the triangle
		int i = 0;

		// scale points to fit maxN
		double maxN = 40;
		if (Math.abs(maxN / (limitsMax.x - limitsMin.x)) < Math.abs(maxN / (limitsMax.y - limitsMin.y))) {
			scaleTo = maxN / Math.abs(limitsMax.x - limitsMin.x);
			xOffset = -scaleTo * limitsMin.x;
			yOffset = maxN / 2 - scaleTo * Math.abs(limitsMax.y + limitsMin.y) / 2;
		} else {
			scaleTo = maxN / Math.abs(limitsMax.y - limitsMin.y);
			yOffset = -scaleTo * limitsMin.y;
			xOffset = maxN / 2 - scaleTo * Math.abs(limitsMax.x + limitsMin.x) / 2;
		}

		for (Triangle2D tr : tR2) {
			i++;
			double x1 = tr.a.x * scaleTo + xOffset;
			double y1 = tr.a.y * scaleTo + yOffset;
			double x2 = tr.b.x * scaleTo + xOffset;
			double y2 = tr.b.y * scaleTo + yOffset;
			double x3 = tr.c.x * scaleTo + xOffset;
			double y3 = tr.c.y * scaleTo + yOffset;
			double x4 = tr.getCircumCenter().x * scaleTo + xOffset;
			double y4 = tr.getCircumCenter().y * scaleTo + yOffset;
			System.out.printf("Circum Center %d: x=%.14f, y=%.14f\n", i, x4, y4);

			// double[][] A = new double[3][3];
			// A[0] = new double[] { 1, x1, y1 };
			// A[1] = new double[] { 1, x2, y2 };
			// A[2] = new double[] { 1, x3, y3 };
			// double da = MatrixOperations.matrixDeterminant(A);

			// We use the fomart of ax + y = c for simplification
			// a == slope, c == const below
			pw.printf("tin(id,x,y)  :- id=%d", i);

			// point x1 and x2
			if (x1 == x2)
				if (x1 > x3)
					pw.printf(", x <= %.2f", x1);
				else
					pw.printf(", x >= %.2f", x1);
			else {
				double slope1 = (y2 - y1) / (x1 - x2);
				double const1 = (x1 * y2 - x2 * y1) / (x1 - x2);
				if (y1 == y2)
					if (y3 >= y1)
						pw.printf(", y >= %.2f", y1);
					else
						pw.printf(", y <= %.2f", y1);
				else if (slope1 * x4 + y4 >= const1)
					if (slope1 == 0)
						pw.printf(", y >= %.2f", const1);
					else
						pw.printf(", %.2fx + y >= %.2f", slope1, const1);
				else if (slope1 == 0)
					pw.printf(", y <= %.2f", const1);
				else
					pw.printf(", %.2fx + y <= %.2f", slope1, const1);
			}
			// point x1 and x3

			if (x1 == x3)
				if (x1 > x2)
					pw.printf(", x <= %.2f", x1);
				else
					pw.printf(", x >= %.2f", x1);
			else {
				double slope2 = (y3 - y1) / (x1 - x3);
				double const2 = (x1 * y3 - x3 * y1) / (x1 - x3);
				if (y1 == y3)
					if (y2 >= y1)
						pw.printf(", y >= %.2f", y1);
					else
						pw.printf(", y <= %.2f", y1);
				else if (slope2 * x4 + y4 >= const2)
					if (slope2 == 0)
						pw.printf(", y >= %.2f", const2);
					else
						pw.printf(", %.2fx + y >= %.2f", slope2, const2);
				else if (slope2 == 0)
					pw.printf(", y <= %.2f", const2);
				else
					pw.printf(", %.2fx + y <= %.2f", slope2, const2);
			}

			if (x2 == x3) {
				if (x2 > x1)
					pw.printf(", x <= %.2f", x2);
				else
					pw.printf(", x >= %.2f", x2);
				pw.println(".<br>");
			}else {

				double slope3 = (y2 - y3) / (x3 - x2);
				double const3 = (x3 * y2 - x2 * y3) / (x3 - x2);
				if (y2 == y3)
					if (y1 >= y2)
						pw.printf(", y >= %.2f", y2);
					else
						pw.printf(", y <= %.2f", y2);
				else if (slope3 * x4 + y4 >= const3)
					if (slope3 == 0)
						pw.printf(", y >= %.2f", const3);
					else
						pw.printf(", %.2fx + y >= %.2f", slope3, const3);
				else if (slope3 == 0)
					pw.printf(", y <= %.2f", const3);
				else
					pw.printf(", %.2fx + y <= %.2f", slope3, const3);
				pw.println(".<br>");
			}
		}
		pw.println("end %MLPQ%");
		pw.print("</body>");
        pw.print("</html>");
		pw.close();

	}

	static void printTriangles(List<Triangle2D> trs) throws IOException {
		// create a new empty document
		PDDocument pd = new PDDocument();

		// create a new blank page
		PDPage page = new PDPage();
		pd.addPage(page);
		PDRectangle box = page.getArtBox();
		System.out.println("max xs: " + limitsMax.x + " and max ys: " + limitsMax.y);
		System.out.println("min xs: " + limitsMin.x + " and min ys: " + limitsMin.y);

		// scale points to fit the page
		if (Math.abs(box.getWidth() / (limitsMax.x - limitsMin.x)) < Math
				.abs(box.getHeight() / (limitsMax.y - limitsMin.y))) {
			scaleTo = 0.9 * box.getWidth() / Math.abs(limitsMax.x - limitsMin.x);
			xOffset = 0.05 * box.getWidth() - scaleTo * limitsMin.x;
			yOffset = box.getHeight() / 2 - scaleTo * Math.abs(limitsMax.y + limitsMin.y) / 2;
		} else {
			scaleTo = 0.9 * box.getHeight() / Math.abs(limitsMax.y - limitsMin.y);
			yOffset = 0.05 * box.getHeight() - scaleTo * limitsMin.y;
			xOffset = box.getWidth() / 2 - scaleTo * Math.abs(limitsMax.x + limitsMin.x) / 2;
		}

		// Create a new font object selecting one of the PDF base fonts
		PDFont font = PDType1Font.HELVETICA_BOLD;

		// Start a new content stream which will "hold" the to be created content
		try {
			PDPageContentStream cStream = new PDPageContentStream(pd, page);
			// Define a text content stream using the selected font, moving the cursor and
			cStream.setFont(font, 12);
			cStream.setNonStrokingColor(0, 0, 0); // black text
			for (Triangle2D tr : trs) {
				cStream.moveTo((float) (tr.a.x * scaleTo + xOffset), (float) (tr.a.y * scaleTo + yOffset));
				cStream.lineTo((float) (tr.b.x * scaleTo + xOffset), (float) (tr.b.y * scaleTo + yOffset));
				cStream.moveTo((float) (tr.b.x * scaleTo + xOffset), (float) (tr.b.y * scaleTo + yOffset));
				cStream.lineTo((float) (tr.c.x * scaleTo + xOffset), (float) (tr.c.y * scaleTo + yOffset));
				cStream.moveTo((float) (tr.c.x * scaleTo + xOffset), (float) (tr.c.y * scaleTo + yOffset));
				cStream.lineTo((float) (tr.a.x * scaleTo + xOffset), (float) (tr.a.y * scaleTo + yOffset));
			}
			cStream.stroke();
			cStream.close();

		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// save document
		try {
			pd.save("textOnBackground.pdf");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (COSVisitorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// close the document
		try {
			pd.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
