package com.smp.dms;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class LoginFilter implements Filter{

  private FilterConfig config = null;
  FilterChain chain;

  public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain)throws IOException, ServletException{
            HttpServletResponse res= (HttpServletResponse)response;
            HttpServletRequest req=(HttpServletRequest)request;
              HttpSession  session=req.getSession(false);
          String application="";
        if(session != null)
        {
       application =(String)session.getAttribute("application");
        }
        if (session != null && application.equals("NEWDMS")) {
                 String userid = (String)session.getAttribute("userid");
	            if (userid == null)
                    {
	                System.out.println("currentUser null");
	                res.sendRedirect(req.getContextPath()+"/NEWDMS");
                    }
                    else
                    {
                     String userrole = (String)session.getAttribute("userrole");
                     String url=new String(req.getRequestURL());
                     String s1=url.substring(url.lastIndexOf("/")+1);
                     url=url.substring(0,url.lastIndexOf("/"));
                     String searchstr=url.substring(url.lastIndexOf("/")+1);

                      System.out.println(searchstr);
                       if(userrole.equals("admin"))
                       {
                         chain.doFilter(request, response);
                       }
                       else if(userrole.equals("manager"))
                       {
                         chain.doFilter(request, response);
                       }
                       else if(userrole.equals("employee"))
                      {
                        if(searchstr.equals("admin"))
                        {
                            res.sendRedirect(req.getContextPath()+"/404.jsp");
                        }
                        else if(searchstr.equals("manager"))
                       {
                        res.sendRedirect(req.getContextPath()+"/404.jsp");
                         }
                        else
                            chain.doFilter(request, response);
                      }
                       else if(userrole.equals("general"))
                      {
                          if(searchstr.equals("admin")||searchstr.equals("manager")||searchstr.equals("billing")||searchstr.equals("challan")||searchstr.equals("chl_mst")||searchstr.equals("master"))
                        {
                             res.sendRedirect(req.getContextPath()+"/404.jsp");
                        }
                        else
                            chain.doFilter(request, response);
                      }
                        // chain.doFilter(request, response);
                    }
            
                 }
              else
                    {
                      res.sendRedirect(req.getContextPath()+"/NEWDMS");
                    }


    }
  
  public void destroy()
  {
      this.config = null;

  }
  public void init(FilterConfig config) {
    this.config = config;
  }
}