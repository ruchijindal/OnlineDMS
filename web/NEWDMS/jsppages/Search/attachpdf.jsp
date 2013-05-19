
 <% response.setHeader( "Pragma", "no-cache");
    response.setHeader( "Cache-Control", "no-store, no-cache");
    response.setDateHeader ("Expires", 0);
 %>

 <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*,java.util.StringTokenizer,java.util.*,java.io.*" errorPage="" %>
<%!
  String userrole;
  int t=0;
  int pt=0;
  String cons_no;
  String sec;
  String division;
%>

<html>
    <title>Attach Pdf</title>
    <jsp:include page="../common/header.jsp"/>
    <body>
        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
        <jsp:include page="../common/navbar.jsp"/>
            <div id="main-content"> <!-- Main Content Section with everything -->
                <div class="content-box">
                    <div class="content-box-header"> <!-- Add the class "closed" to the Content box header to have it closed by default -->
                        <h3>Upload File</h3>
                    </div> <!-- End .content-box-header -->
                    <div class="content-box-content">
                        <div class="tab-content default-tab">
<%
    userrole=(String)session.getAttribute("userrole");
    try{
    cons_no=request.getParameter("cons_no");
    sec=request.getParameter("sec").trim();
    division=request.getParameter("division");
    }
    catch(Exception e)
            {
        System.out.println("Exception in attachpdf:"+e);
    }

    if(userrole.equals("admin")||userrole.equals("employee"))
    {
        try
        {
            if(request.getParameter("t")!=null||(!request.getParameter("t").equals("")))
            t=Integer.parseInt(request.getParameter("t"));
         }
         catch(Exception ex)
         {
            System.err.println("Exception in attachpdf:"+ex);
         }
         if(t==1)
         {
%>
                            <div class="notification success png_bg">
                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                <div>
                                    File uploaded successfully.
                                </div>
                            </div>
<%
         }
         else if(t==2)
         {
%>
                            <div class="notification error1 png_bg">
			    <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                <div>
			             File has not been uploaded.Try again.
				</div>
                            </div>
<%
          }
          t=0;
%>
                            <form  id="form1"  method="POST" action="mergepdf.jsp" enctype="MULTIPART/FORM-DATA">
                                <!--<input type="hidden" name="sec" value="sector's number" />-->
                                Choose file to be uploaded:<br/>
                                <input type="file" name="<%=sec%>" />&nbsp;
                                <input type="submit" class="button" value="Merge"/>
                            </form>
                        </div> <!-- End #tab3 -->
                    </div> <!-- End .content-box-content -->
                </div> <!-- End .content-box -->

 <%
    }

%>
            </div>
        </div>
    </body>
</html>