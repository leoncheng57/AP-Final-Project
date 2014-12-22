
import javax.swing.JFrame;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.Ellipse2D;

import javax.swing.JPanel;
public class Driver extends Jpanel {
    public void examplePaint(Graphics g) {
	Graphics2D fillerOfShapes = (Graphics2D)g;
	fillerOfShapes.setColor(Color.RED);
	fillerOfShapes.drawOval( 100, 100 , 10 , 10);
	fillerOfShapes.fillOval(1,1, 15 , 5);
	    
    }

    
	public static void main(String[] args) {
		JFrame frame = new JFrame("Tower Defence");
		frame.add(new Driver());
		frame.setSize(900, 900);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
}
