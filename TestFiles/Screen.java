import javax.swing.JPanel;

public class Screen extends JPanel implements Runnable{

    Thread thread = new Thread(this);

    public Screen (Frame frame){
	thread.start();
    }

    public void run(){
	System.out.println("Success");
    }
    
}
