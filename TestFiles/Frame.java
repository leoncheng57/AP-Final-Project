import javax.swing.JFrame;

public class Frame extends JFrame{
    public static void main(String[] args){
	new Frame();
    }

    public Frame(){
	new JFrame();
	
	setSize(800,600);
	setTitle("Tower Defense Game!");
	setDefaultCloseOperation(EXIT_ON_CLOSE);
	setVisible(true);
    
	Screen screen = new Screen(this);
	this.add(screen);
    }
    
}
