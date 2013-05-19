<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");
            response.setDateHeader("Expires", 0);
%>

<%--
   Document   : home
   Created on : 24 Feb, 2010, 2:59:31 PM
   Author     : smp
--%>

<%@page  language="java" import="java.util.*,java.sql.*,java.net.URLEncoder,javax.servlet.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*"  %>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<html>
    <title>Consumer Details</title>
    <a name="Top"></a>
    <jsp:include page="../common/header.jsp"/>
    <script  type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.validate_1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/NEWDMS/resources/jquery/jquery.maskedinput-1.2.2.js"></script>
    <%!        String userrole;
        String userid;
    %>
    <script type="text/javascript">

        $(document).ready(function()
        {
            $("#bill_to").mask("99/99/99");
            $("#arrearupto").mask("99/99/99");
            $("#bill_fr").mask("99/99/99");
            $("#billdate").mask("99/99/99");
            $("#duedate").mask("99/99/99");
            $("#bl_per_fr").mask("99/99/99");
            $("#bl_per_to").mask("99/99/99");
            $("#due_dt").mask("99/99/99");
            $("#pay_date").mask("99/99/99");
            $("#newbill").validate();
            for(k=0;k<document.forms.length;k++)
            {
                document.forms[k].id="form"+k;
                // alert(document.forms[k].id);
            }
            for(k=0;k<document.forms.length;k++)
            {
                f=document.forms[k].id;
                       
                $("#"+f+"").validate();
            }
           
                     

        });

        function popitup(url) {
            newwindow=window.open(url,'name','height=1200,width=1200');
            if (window.focus) {newwindow.focus()}
            return false;
        }
        window.onload = function()
        {
            document.getElementById("bl_per_fr").focus();
        }

        function confirmDel()
        {
            var msg;
            msg="Do you want to delete this record permanently?"
            var agree=confirm(msg);
            if(agree)
                return true;
            else
                return false;

        }

        function confirmDelpdf()
        {
            var msg;
            msg="Do you want to delete this pdf file permanently?"
            var agree=confirm(msg);
            if(agree)
                return true;
            else
                return false;

        }
        
        function makeEditable()
        {
            var txt_inp = document.getElementsByTagName('input');
            var TxtInpId;
            var i, j=1;

            for(i=0; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text")
                {
                    var x = txt_inp[i];
                    TxtInpId = x.id;  // get or set id
                    if(TxtInpId == "" &&(x.name=="cons_nm1"||x.name=="sec"||x.name=="blk_no"||x.name=="flat_no"||x.name=="con_tp"||x.name=="cons_ctg"||
                        x.name=="flat_type"||x.name=="plot_size"||x.name=="pipe_size"||x.name=="reg_no"||x.name=="esti_no"||x.name=="esti_amt"||
                        x.name=="secu"||x.name=="esti1_amt"||x.name=="nodue_amt"||x.name=="trans_nm"||x.name=="trf"||
                        x.name=="conn_dt"||x.name=="esti_dt"||x.name=="nodue_dt"||x.name=="cal_date"||x.name=="pos_date"||x.name=="comp_date"))
                    {
                        x.id = TxtInpId = "CId"+j; // We are dynamically setting and ID
                        Id="CId"+j;
                        document.getElementById(Id).removeAttribute("readonly");
                        if(x.name=="conn_dt"||x.name=="esti_dt"||x.name=="nodue_dt"||x.name=="cal_date"||x.name=="pos_date"||x.name=="comp_date")
                        {
                            $("#"+Id).mask("99/99/99");
                        }
                        // x.id="";
                        j++;

                    }
                }
            }

            ///////////////////////////////////////////////////////////

            var txt_select=document.getElementsByTagName('select');
            var TxtSelectId;
            var s,t=1;
            for(s=0; s< txt_select.length; s++)
            {
                var z = txt_select[s]
                TxtSelectId = z.id;  // get or set id

                if(TxtSelectId == "")
                {
                    z.id = TxtSelectId = "z"+t; // We are dynamically setting and ID
                    document.getElementById(TxtSelectId).removeAttribute("disabled");
                    t++;
                }

            }

            document.getElementById("editConsumer").removeAttribute("style");
            /////////////////////////////////////////////////////////////
       
            
        }

        function makeEditableChl3(chl)
        {
            

            var txt_inp = document.getElementsByTagName('input');
            var TxtInpId;
            var i, j=1,k=1;

            for(i=0; i< txt_inp.length; i++)
            {

                if(txt_inp[i].type == "text")
                {
                    var x = txt_inp[i];
                    // get or set id
                    TxtInpId = x.id;
                    if(TxtInpId == ""&&(x.name=="bl_per_fr"||x.name=="bl_per_to"||x.name=="due_dt"||x.name=="bill_amt"||x.name=="surcharge"||x.name=="paid_amt"||x.name=="pay_date"||
                        x.name=="arrear"||x.name=="credit"||x.name=="recp_no"||x.name=="dis_cd"||x.name=="noc"||x.name=="rmc"|| x.name=="chlsecu"||x.name=="t_fee"||
                        x.name=="css"||x.name=="bnk_cd"||x.name=="br_nm"))
                    {
                        x.id = TxtInpId = "Id"+j; // We are dynamically setting and ID
                        Id="Id"+j;
                        // document.getElementById(Id).removeAttribute("readonly");
                        if((j==((chl-1)*18)+k) && k<=18)
                        {
                            document.getElementById(Id).removeAttribute("readonly");
                 
                            if(x.name=="bl_per_fr"||x.name=="bl_per_to"||x.name=="due_dt"||x.name=="pay_date")
                            {
                                $("#"+Id).mask("99/99/99");
                            }
                            k++;
                            document.getElementById("edit"+chl).style.display="none";
                            document.getElementById("save"+chl).style.display="inline-block";
                            document.getElementById("del"+chl).style.display="inline-block";
                        }
                        //x.id="";
                        j++;
                    }
                }
         
            }


        }

        function makeEditableSew()
        {
            document.getElementById("s_reg_no").removeAttribute("readonly");
            document.getElementById("s_con_dt").removeAttribute("readonly");
            document.getElementById("s_est_no").removeAttribute("readonly");
            document.getElementById("s_est_amt").removeAttribute("readonly");
            document.getElementById("s_est_pdt").removeAttribute("readonly");
            document.getElementById("s_est_pamt").removeAttribute("readonly");
            document.getElementById("s_nodue_amt").removeAttribute("readonly");
            document.getElementById("s_nodue_dt").removeAttribute("readonly");
            document.getElementById("s_secu").removeAttribute("readonly");
            $("#s_con_dt").mask("99/99/99");
            $("#s_nodue_dt").mask("99/99/99");
            $("#s_est_pdt").mask("99/99/99");
            document.getElementById("editSewer").removeAttribute("style");
        }

        /******************************************************/
        function GetXmlHttpObject()
        {
            var xmlHttp=null;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp=new XMLHttpRequest();
            }
            catch (e)
            {
                //Internet Explorer
                try
                {
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            return xmlHttp;
        }
        function checkduedate(date)
        {
            var d=document.getElementById(date).value ;
            var d2=new Date();
            var d1=new Date(parseInt("20"+d.substring(6,8),10),parseInt(d.substring(3,5),10)-1,parseInt(d.substring(0,2)),10);;


            if(d1.getTime()<=d2.getTime())
            {
                if(date=="duedate")
                {
                    // document.getElementById("billId").disabled = true;
                    document.getElementById("cduedate").removeAttribute("style");
                }
                if(date=="duedate1")
                {
                    //document.getElementById("billId").disabled = true;
                    document.getElementById("cduedate1").removeAttribute("style");
                }

            }else{
                if(date=="duedate")
                {
                    // document.getElementById("billId").disabled = false;
                    document.getElementById("cduedate").style.visibility="hidden";
                }
                if(date=="duedate1")
                {
                    //document.getElementById("billId").disabled =false;
                    document.getElementById("cduedate1").style.visibility="hidden";
                }
            }
        }
        function checkbilltodate()
        {
            var d=document.getElementById("bill_to").value ;
            noc
            var d1=new Date(parseInt("20"+d.substring(6,8),10),parseInt(d.substring(3,5),10)-1,parseInt(d.substring(0,2)),10);
         

            var d2=new Date();
            d2.setMonth(4-1,1);
            //document.write(d2);
            if(d1.getTime()<=d2.getTime())
            {
            
                // document.getElementById("billId").disabled = true;
                document.getElementById("ctodate").removeAttribute("style");
               

            }else{
                // document.getElementById("billId").disabled = false;
                document.getElementById("ctodate").style.visibility="hidden";
               
            }
         
        }


        function checkBillGeneration()
        {
            var bill_to = document.getElementById("bill_to").value;
            var billToDate=new Date(parseInt("20"+bill_to.substring(6,8),10),parseInt(bill_to.substring(3,5),10)-1,parseInt(bill_to.substring(0,2)),10);
            var currentDate=new Date();
            currentDate.setMonth(4-1,1);

            var duedate = document.getElementById("duedate").value;
            var currentDate1=new Date();

            var due_date=new Date(parseInt("20"+duedate.substring(6,8),10),parseInt(duedate.substring(3,5),10)-1,parseInt(duedate.substring(0,2)),10);

            if(!(due_date.getTime()<=currentDate1.getTime())&&!(billToDate.getTime()<=currentDate.getTime())){
        
                if((bill_to != "__/__/__") && (duedate != "__/__/__") && (bill_to != "") && (duedate != "") )
                    {
                document.getElementById("wait").style.display="inline";
                    }
                return true;
            }else
            {  
                return false;
            }

        }
        function cancel1()
        {
            xmlHttp=GetXmlHttpObject()

            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request")
                return
            }

            var url="<%= request.getContextPath()%>/cancelBillPdf"


            xmlHttp.onreadystatechange=stateChanged
            xmlHttp.open("GET",url,true)
            xmlHttp.send(null)
           
        }
        function cancel2()
        {
            document.getElementById("getPdf").style.display="none";
            document.getElementById("cancel").style.display="none";
            document.getElementById("billId").style.display="inline";
        }
        function stateChanged()
        {
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
            {
                window.location.reload();
            }
        }
        function render()
        {
            if(<%= session.getAttribute("billGenFlag")%> != "1")
            {

            }else{
                
                document.getElementById("getPdf").removeAttribute("style");
                document.getElementById("cancel").removeAttribute("style");
                document.getElementById("billId").style.display="none";
            }
        }
        
        /******************************************************/


    </script>
    <%
                userrole = (String) session.getAttribute("userrole");
                userid = (String) session.getAttribute("userid");
    %>
    <body onload="render()">

        <div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->

            <jsp:include page="../common/navbar.jsp"/>
            <div id="main-content"> <!-- Main Content Section with everything -->





                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">

                        <h3>Consumer Details</h3><a href="#bottom"><img  alt="bottom" src="<%=request.getContextPath()%>/NEWDMS/resources/images/icons/top.png"/></a>

                        <div class="content-box-tabs">
                            <%    if (userrole.equals("admin") || userrole.equals("manager")) {
                            %>
                            <c:if test="${!(consumerDetail.status=='A'||consumerDetail.status==null)}">
                                <a href="<%= request.getContextPath()%>/AuthoriseController?cons_no=${consumerDetail.consNo}"><label class="button">AUTHORISE</label></a>
                            </c:if>
                            <a href="<%= request.getContextPath()%>/deleteConsumerPdf?cons_no=${consumerDetail.consNo}&sec=${consumerDetail.sector}" onclick="return confirmDelpdf()"><label class="button">DELETEPDF</label></a>
                            <a href="<%= request.getContextPath()%>/DeleteConsumerDetails?id=${consumerDetail.id}"><label class="button" onclick="return confirmDel()">DELETE</label></a>
                            <%
                                        }
                            %>
                            <a href="attachpdf.jsp?cons_no=&sec=&division=&vpflag=2"><label class="button">ATTACHPDF</label></a>
                            <a href="<%= request.getContextPath()%>/viewConsumerPdf?cons_no=${consumerDetail.consNo}&sec=${consumerDetail.sector}" ><label class="button">VIEWPDF</label></a>
                            <a href="#" onclick="makeEditable()" ><label class="button">EDIT</label></a><!-- href must be unique and match the id of target div -->
                            <a href="<%= request.getContextPath()%>/ConsumerDetails?cons_no=${consumerDetail.consNo}"><label class="button">CANCEL</label></a>
                        </div>





                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">

                        <div class="tab-content default-tab" id="tab1">
                            <form method="post"  id="" action="<%= request.getContextPath()%>/UpdateConsumerDetails">
                                <input type="hidden" name="rowid" value=""/>
                                <noscript> <!-- Show a notification if the user has disabled javascript -->
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
						Javascript is disabled or is not supported by your browser. Please upgrade your browser or Enable Javascript in your browser.
                                        </div>
                                    </div>

                                </noscript>

                                <!--   <div class="notification error1 png_bg">
                                       <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                       <div>
			             File could not be viewed.
                                       </div>
                                   </div>-->
                                <c:if test="${insufficientDetailFlag eq '1'}">
                                    <% request.setAttribute("insufficientDetailFlag", "0");%>
                                    <div class="notification error1 png_bg">
                                        <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                        <div>
			          Insufficient Details !
                                        </div>
                                    </div>
                                </c:if>

                                <c:set var="t" value="<%= request.getAttribute("t")%>"/>

                                <c:choose>
                                    <c:when test="${t=='1'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			             Record updated.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t=='2'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           There was some error.
                                            </div>
                                        </div>
                                    </c:when>

                                    <c:when test="${t=='3'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           pdf file does not exist!
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t=='4'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
                                                File is readonly can't be deleted.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t=='5'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
                                                Directory is not empty.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t=='6'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
                                                There was some error.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t=='7'}">
                                        <% request.setAttribute("t", 0);%>
                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
                                                File deleted successfully.
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>


                                <c:set var="t1" value="<%= request.getAttribute("t1")%>"/>
                                <c:choose>
                                    <c:when test="${t1=='1'}">
                                        <%request.setAttribute("t1", 0);%>
                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           Record inserted.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t1=='2'}">
                                        <% request.setAttribute("t1", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           There was some error.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t1=='3'}">
                                        <% request.setAttribute("t1", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           First Authorise the Master.
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>


                                <c:choose>
                                    <c:when test="${t2=='1'}">
                                        <%request.setAttribute("t2", 0);%>
                                        <div class="notification success png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           Record deleted successfully.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${t2=='2'}">
                                        <%request.setAttribute("t2", 0);%>
                                        <div class="notification error1 png_bg">
                                            <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
                                            <div>
			           There was some error.
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>

                                <input type="hidden" name="id" value="${consumerDetail.id}" name="id"/>
                                <c:choose>
                                    <c:when test="${!(consumerDetail.status=='A'||consumerDetail.status==null)}">

                                        <table  class="ed" cellspacing="0" cellpadding="0" style="border:2px solid  red;" >

                                            <tr>
                                                <th>Consumer No</th>
                                                <td><input type="text" name="cons_no"  class="required" readonly value="${consumerDetail.consNo}"   /></td>
                                                <th>Estimate No</th>
                                                <td><input type="text" name="esti_no"   readonly value="${consumerDetail.estiNo}" /></td>
                                            </tr>
                                            <tr>
                                                <th>Consumer Name</th>
                                                <td><input type="text" name="cons_nm1"  readonly value="${consumerDetail.consNm1}" /></td>
                                                <th>Estimate Amount</th>
                                                <td><input type="text" name="esti_amt"   class="number" value="${consumerDetail.estiAmt}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Address(Sec/Blk/FlatNo)</th>
                                                <td><input type="text" name="sec" value="${consumerDetail.sector}" size="4" readonly /><input type="text" name="blk_no"    value="${consumerDetail.blkNo}"  size="4" readonly />
                                                    <input type="text" name="flat_no"   value="${consumerDetail.flatNo}" size="5" readonly /></td>
                                                <th>Security</th>
                                                <td><input type="text" name="secu"  class="number"  value="${consumerDetail.secu}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Connection Type</th>
                                                <td>
                                                    <select name="con_tp" style="width: 183px" disabled>


                                                        <c:if test="${consumerDetail.conTp eq 'R'}">

                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'I'}">
                                                            <option value="I">Industrial</option>
                                                            <option value="R">Residential</option>

                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'C'}">
                                                            <option value="C">Commercial</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>

                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'T'}">
                                                            <option value="T">Institutional</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>

                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'S'}">
                                                            <option value="S">Staff</option>

                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>

                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'G'}">

                                                            <option value="G">Group Housing</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>

                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq ''}">
                                                            <option value="">N.A</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                        </c:if>

                                                    </select>
                                                </td>
                                                <th>Estimate Date</th>
                                                <td> <fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.estiDt}" var="esti_dt"/><input type="text" name="esti_dt"  class="date"  value="${esti_dt}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Connection Category</th>
                                                <td>
                                                    <select name="cons_ctg" style="width: 183px" disabled>
                                                        <c:if test="${consumerDetail.consCtg eq ''}">
                                                            <option value="">N.A</option>
                                                            <option value="R">Regular</option>
                                                            <option value="T">Temporary</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.consCtg eq 'R'}">
                                                            <option value="R">Regular</option>
                                                            <option value="T">Temporary</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.consCtg eq 'T'}">
                                                            <option value="T">Temporary</option>
                                                            <option value="R">Regular</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                    </select>
                                                </td>
                                                <th>Paid Amount</th>
                                                <td><input type="text" name="esti1_amt" class="number"  value="${consumerDetail.esti1Amt}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Flat Type</th>
                                                <td ><input type="text" name="flat_type" value="${consumerDetail.flatType}" readonly /></td>
                                                <th>No Due Amount</th>
                                                <td><input type="text" name="nodue_amt"  class="number" value="${consumerDetail.nodueAmt}" readonly/></td>
                                            </tr>
                                            <tr>
                                                <th>Plot Size</th>
                                                <td><input type="text" name="plot_size"    value="${consumerDetail.plotSize}" readonly /></td>
                                                <th>No Due Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.nodueDt}" var="nodue_dt"/><input type="text" name="nodue_dt"   class="date" value="${nodue_dt}" readonly/></td>
                                            </tr>
                                            <tr>
                                                <th>Pipe Size</th>
                                                <td><input type="text" name="pipe_size" value="${consumerDetail.pipeSize}" readonly /></td>

                                                <th>Regisration No</th>
                                                <td><input type="text" name="reg_no"    value="${consumerDetail.regNo}" readonly /></td>

                                            </tr>
                                            <tr>


                                                <th>Transfer Name</th>
                                                <td><input type="text" name="trans_nm"    value="${consumerDetail.transNm}" readonly/></td>

                                                <th>TRF</th>
                                                <td><input type="text" name="trf"  readonly value="${consumerDetail.trf}"/></td>

                                            </tr>
                                            <tr>
                                                <th>Connection Date</th>
                                                <td>
                                                    <fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.connDt}" var="conn_date"/><input type="text" name="conn_dt"  class="date" value="${conn_date}" readonly /></td>
                                                <th>Calculation Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.calDate}" var="cal_date"/><input type="text" name="cal_date" class="date" value="${cal_date}" readonly /></td>
                                            </tr>

                                            <tr>
                                                <th>Possession Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.posDate}" var="pos_date"/><input type="text" name="pos_date" class="date" value="${pos_date}" readonly /></td>
                                                <th>Completion Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.compDate}" var="comp_date"/><input type="text" name="comp_date"  class="date"  value="${comp_date}" readonly /></td>
                                            </tr>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <table  class="ed" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <th>Consumer No</th>
                                                <td><input type="text" name="cons_no"  class="required" readonly value="${consumerDetail.consNo}"   /></td>
                                                <th>Estimate No</th>
                                                <td><input type="text" name="esti_no"   readonly value="${consumerDetail.estiNo}" /></td>
                                            </tr>
                                            <tr>
                                                <th>Consumer Name</th>
                                                <td><input type="text" name="cons_nm1"  readonly value="${consumerDetail.consNm1}" /></td>
                                                <th>Estimate Amount</th>
                                                <td><input type="text" name="esti_amt"   class="number" value="${consumerDetail.estiAmt}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Address(Sec/Blk/FlatNo)</th>
                                                <td><input type="text" name="sec" value="${consumerDetail.sector}" size="4" readonly /><input type="text" name="blk_no"    value="${consumerDetail.blkNo}"  size="4" readonly />
                                                    <input type="text" name="flat_no"   value="${consumerDetail.flatNo}" size="5" readonly /></td>
                                                <th>Security</th>
                                                <td><input type="text" name="secu"  class="number"  value="${consumerDetail.secu}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Connection Type</th>
                                                <td>
                                                    <select name="con_tp" style="width: 183px" disabled>


                                                        <c:if test="${consumerDetail.conTp eq 'R'}">

                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'I'}">
                                                            <option value="I">Industrial</option>
                                                            <option value="R">Residential</option>

                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'C'}">
                                                            <option value="C">Commercial</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>

                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'T'}">
                                                            <option value="T">Institutional</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>

                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'S'}">
                                                            <option value="S">Staff</option>

                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>

                                                            <option value="G">Group Housing</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq 'G'}">

                                                            <option value="G">Group Housing</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>

                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.conTp eq ''}">
                                                            <option value="">N.A</option>
                                                            <option value="R">Residential</option>
                                                            <option value="I">Industrial</option>
                                                            <option value="C">Commercial</option>
                                                            <option value="T">Institutional</option>
                                                            <option value="S">Staff</option>
                                                            <option value="G">Group Housing</option>
                                                        </c:if>

                                                    </select>
                                                </td>
                                                <th>Estimate Date</th>
                                                <td> <fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.estiDt}" var="esti_dt"/><input type="text" name="esti_dt"  class="date"  value="${esti_dt}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Connection Category</th>
                                                <td>
                                                    <select name="cons_ctg" style="width: 183px" disabled>
                                                        <c:if test="${consumerDetail.consCtg eq ''}">
                                                            <option value="">N.A</option>
                                                            <option value="R">Regular</option>
                                                            <option value="T">Temporary</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.consCtg eq 'R'}">
                                                            <option value="R">Regular</option>
                                                            <option value="T">Temporary</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                        <c:if test="${consumerDetail.consCtg eq 'T'}">
                                                            <option value="T">Temporary</option>
                                                            <option value="R">Regular</option>
                                                            <option value="">N.A</option>
                                                        </c:if>
                                                    </select>
                                                </td>
                                                <th>Paid Amount</th>
                                                <td><input type="text" name="esti1_amt" class="number"  value="${consumerDetail.esti1Amt}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th>Flat Type</th>
                                                <td ><input type="text" name="flat_type" value="${consumerDetail.flatType}" readonly /></td>
                                                <th>No Due Amount</th>
                                                <td><input type="text" name="nodue_amt"  class="number" value="${consumerDetail.nodueAmt}" readonly/></td>
                                            </tr>
                                            <tr>
                                                <th>Plot Size</th>
                                                <td><input type="text" name="plot_size"    value="${consumerDetail.plotSize}" readonly /></td>
                                                <th>No Due Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.nodueDt}" var="nodue_dt"/><input type="text" name="nodue_dt"   class="date" value="${nodue_dt}" readonly/></td>
                                            </tr>
                                            <tr>
                                                <th>Pipe Size</th>
                                                <td><input type="text" name="pipe_size" value="${consumerDetail.pipeSize}" readonly /></td>

                                                <th>Regisration No</th>
                                                <td><input type="text" name="reg_no"    value="${consumerDetail.regNo}" readonly /></td>

                                            </tr>
                                            <tr>


                                                <th>Transfer Name</th>
                                                <td><input type="text" name="trans_nm"    value="${consumerDetail.transNm}" readonly/></td>

                                                <th>TRF</th>
                                                <td><input type="text" name="trf"  readonly value="${consumerDetail.trf}"/></td>

                                            </tr>
                                            <tr>
                                                <th>Connection Date</th>
                                                <td>
                                                    <fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.connDt}" var="conn_date"/><input type="text" name="conn_dt"  class="date" value="${conn_date}" readonly /></td>
                                                <th>Calculation Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.calDate}" var="cal_date"/><input type="text" name="cal_date" class="date" value="${cal_date}" readonly /></td>
                                            </tr>

                                            <tr>
                                                <th>Possession Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.posDate}" var="pos_date"/><input type="text" name="pos_date" class="date" value="${pos_date}" readonly /></td>
                                                <th>Completion Date</th>
                                                <td><fmt:formatDate pattern="dd/MM/yy" value="${consumerDetail.compDate}" var="comp_date"/><input type="text" name="comp_date"  class="date"  value="${comp_date}" readonly /></td>
                                            </tr>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                                <div align="center"><input id="editConsumer" type="submit" class="button" style="display: none" value="SAVE" /></div>



                            </form>
                        </div>
                    </div>
                </div>



                <a name="sewer_form"></a>
                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Sewer Details</h3>


                        <div class="content-box-tabs">

                            <a href="#sewer_form" onclick="makeEditableSew()"><label class="button">EDIT</label></a>


                            <a href="<%= request.getContextPath()%>/ConsumerDetails?cons_no=${consumerDetail.consNo}" ><label class="button">CANCEL</label></a><!-- href must be unique and match the id of target div -->
                        </div>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">
                        <div>

                            <form method="post" action="<%= request.getContextPath()%>/UpdateSewerDetails">
                                <input type="hidden" name="cons_no" value="${consumerDetail.consNo}"/>
                                <input type="hidden" name="id" value="${sewerDetail.id}"/>
                                <table   class="ed" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <th>Sewer Registration No</th>
                                        <td><input type="text" name="s_reg_no" id="s_reg_no" value="${sewerDetail.SRegNo}"  maxlength="8" readonly/></td>
                                        <th>Sewer Connection Date</th>
                                        <td><fmt:formatDate pattern="dd/MM/yy" value="${sewerDetail.SConDt}" var="s_con_dt"/><input type="text" name="s_con_dt" id="s_con_dt" value="${s_con_dt}" class="date" readonly /></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Estimate No</th>
                                        <td><input type="text" name="s_est_no" id="s_est_no" value="${sewerDetail.SEstNo}" maxlength="8"  readonly/></td>
                                        <th>Sewer Estimate Amount</th>
                                        <td><input type="text" name="s_est_amt" id="s_est_amt" value="${sewerDetail.SEstAmt}" class="number"  readonly /></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Security</th>
                                        <td><input type="text" name="s_secu" id="s_secu" class="number" value="${sewerDetail.SSecu}"  readonly /></td>
                                        <th>Sewer Estimate Paid Date</th>
                                        <td><fmt:formatDate pattern="dd/MM/yy" value="${sewerDetail.SEstPdate}" var="s_est_pdt"/><input type="text" name="s_est_pdt" id="s_est_pdt" value="${s_est_pdt}"  readonly/></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer Estimate Paid Amount</th>
                                        <td><input type="text" name="s_est_pamt" id="s_est_pamt" class="number" value="${sewerDetail.SEstPamt}"  readonly/></td>
                                        <th>Sewer Nodue Amount</th>
                                        <td><input type="text" name="s_nodue_amt" id="s_nodue_amt" class="number" value="${sewerDetail.SNodueAmt}"  readonly/></td>
                                    </tr>
                                    <tr>
                                        <th>Sewer NoDue Date</th>
                                        <td><fmt:formatDate pattern="dd/MM/yy" value="${sewerDetail.SNodueDt}" var="s_nodue_dt"/><input type="text" name="s_nodue_dt" id="s_nodue_dt" class="date" value="${s_nodue_dt}"  readonly/></td>
                                        <td></td><td></td>
                                    </tr>
                                </table>

                                <div align="center"><input id="editSewer" type="submit" class="button" style="display: none;" value="SAVE"/></div>

                            </form>

                        </div>
                    </div>
                </div>

                <a name="bottom"></a>
                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Challan Details</h3><a href="#Top"><img  alt="Top" src="<%=request.getContextPath()%>/NEWDMS/resources/images/icons/bottom.png"/></a>

                        <div class="content-box-tabs">


                            <a href="<%=request.getContextPath()%>/NEWDMS/jsppages/Search/cons_details.jsp?cons_no=${consumerDetail.consNo}&newchl=1#bottom"><label class="button">NEW CHALLAN</label></a>
                            <a href="<%= request.getContextPath()%>/ConsumerDetails?cons_no=${consumerDetail.consNo}"><label class="button">CANCEL</label></a>

                        </div>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">
                        <div>
                            <table   class="ed" cellspacing="0" cellpadding="0">
                                <thead>
                                    <tr>
                                        <th>Bill Fr</th>
                                        <th>Bill To</th>
                                        <th>Due Dt</th>
                                        <th>BillAmt </th>
                                        <th>S/c</th>
                                        <th>PaidAmt</th>
                                        <th>Pay Dt</th>
                                        <th>Arrear</th>
                                        <th>Credit</th>
                                        <th>Recp No</th>
                                        <th>DCd</th>
                                        <th>Noc</th>
                                        <th>RMC</th>
                                        <th>Secu</th>
                                        <th>TFee</th>
                                        <th>Cess</th>
                                        <th>BnCd</th>
                                        <th>BrNm</th>

                                    </tr>
                                </thead>

                                <c:set var="newchl"  value="<%=request.getParameter("newchl")%>"></c:set>
                                <c:if test="${newchl==1}">
                                    <c:set var="newchl" value="0"></c:set>

                                    <form name="newchl" method="post" action="<%=request.getContextPath()%>/insertChallan" >

                                        <input type="hidden" name="cons_no"  value="${consumerDetail.consNo}"/>
                                        <input type="hidden" name="sec"  value="${consumerDetail.sector}"/>
                                        <input type="hidden" name="blk"    value="${consumerDetail.blkNo}"  size="4" />
                                        <input type="hidden" name="flat_no"   value="${consumerDetail.flatNo}" size="5"/>

                                        <tr>
                                            <td><input name="bl_per_fr" id="bl_per_fr"  type="text"  size="5"  class="date"/></td>

                                            <td><input name="bl_per_to" id="bl_per_to" type="text"   size="5"   class="date"/></td>

                                            <td><input name="due_dt"  id="due_dt" type="text"   size="5"   class="date"/></td>

                                            <td><input name="bill_amt" id="bill_amt" type="text"  size="5"  class="number"/></td>

                                            <td><input name="surcharge" id="surcharge" type="text"  size="4"  class="number"/></td>

                                            <td><input name="paid_amt" id="paid_amt" type="text"  size="6"  class="required number"/></td>

                                            <td><input name="pay_date"  id="pay_date" type="text"   size="5"   class="required date"/></td>

                                            <td><input name="arrear" id="arrear" type="text"   size="4"  class="number"/></td>

                                            <td><input type="text"  name="credit"  id="credit" size="4"   class="number"/></td>

                                            <td><input type="text" name="recp_no"  id="recp_no" size="6"   maxlength="8"/></td>

                                            <td> <input name="dis_cd" type="text" id="dis_cd" size="3"  maxlength="1"/></td>

                                            <td><input name="noc" type="text" id="noc"  size="3"  class="number"/></td>

                                            <td><input name="rmc" type="text" id="rmc"   size="3"  class="number"/></td>

                                            <td><input name="chlsecu" type="text" id="chlsecu"  size="3"    class="number"/></td>

                                            <td><input name="t_fee" type="text" id="t_fee"  size="3"  class="number"/></td>

                                            <td><input name="css" type="text"  id="css" size="3"  class="number"/></td>

                                            <td><input type="text" name="bnk_cd" id="bnk_cd"  size="4"/></td>

                                            <td><input name="br_nm" type="text" id="br_nm"  size="4"/></td>
                                            <td><input  type="submit"  class="savebutton" value=""/><a href="cons_details.jsp?cons_no=&sec=#bottom"><div class="delbutton">&nbsp;</div></a></td>

                                        </tr>
                                    </form>
                                </c:if>

                                <c:set var="ch" value="1"/>



                                <c:forEach var="challan" items="${challanDetail}">
                                    <form   id="form1${ch}"  name="challan" method="post" action="<%=request.getContextPath()%>/updateChallan">
                                        <input type="hidden" name="row_id" id="" value="${challan.id}"/>
                                        <input type="hidden" name="cons_no"  value="${challan.consNo}"/>
                                        <input type="hidden" name="sec"  value="${challan.sec}"/>
                                        <c:choose>
                                            <c:when test="${!(challan.status==null||challan.status=='A')}">

                                                <tr style="border:2px solid  red;">

                                                    <td><fmt:formatDate value="${challan.blPerFr}" pattern="dd/MM/yy"  var="blPerFr" /><input name="bl_per_fr" type="text"  size="5"  class="date"  value="${blPerFr}" readonly/></td>

                                                    <td><fmt:formatDate value="${challan.blPerTo}" pattern="dd/MM/yy"  var="blPerTo" /><input name="bl_per_to" type="text"   size="5"   class="date"  value="${blPerTo}" readonly/></td>

                                                    <td><fmt:formatDate value="${challan.dueDt}" pattern="dd/MM/yy"  var="dueDt" /><input name="due_dt" type="text"   size="5"   class="date"  value="${dueDt}" readonly/></td>

                                                    <td><input name="bill_amt" type="text"  size="5" value="${challan.billAmt}" class="number" readonly/></td>

                                                    <td><input name="surcharge" type="text"  size="4" value="${challan.surcharge}" class="number" readonly /></td>

                                                    <td><input name="paid_amt" type="text"  size="6" value="${challan.paidAmt}" class="required number" readonly/></td>

                                                    <td><fmt:formatDate value="${challan.payDate}" pattern="dd/MM/yy" var="payDate" /><input name="pay_date" type="text"   size="5"  value="${payDate}" class="required date" readonly/></td>

                                                    <td><input name="arrear" type="text"   size="4" value="${challan.arrear}" class="number"  readonly/></td>

                                                    <td><input type="text" name="credit"  size="4" value="${challan.credit}"  class="number" readonly /></td>

                                                    <td><input type="text" name="recp_no"  size="6"  value="${challan.recpNo}" maxlength="8" readonly/></td>

                                                    <td> <input name="dis_cd" type="text"  size="3" value="${challan.disCd}"  maxlength="1" readonly /></td>

                                                    <td><input name="noc" type="text"   size="3" value="${challan.noc}" class="number"  readonly/></td>

                                                    <td><input name="rmc" type="text"   size="3" value="${challan.rmc}" class="number"  readonly/></td>

                                                    <td><input name="chlsecu" type="text"  size="3"  value="${challan.secu}"  class="number"  readonly/></td>

                                                    <td><input name="t_fee" type="text"   size="3" value="${challan.TFee}" class="number" readonly/></td>

                                                    <td><input name="css" type="text"  size="3" value="${challan.css}" class="number" readonly/></td>

                                                    <td><input type="text" name="bnk_cd"  size="4" value="${challan.bnkCd}" readonly/></td>

                                                    <td><input name="br_nm" type="text"   size="4" value="${challan.brNm}" readonly/></td>


                                                    <td id="edit${ch}"  style="display:inline-block">  <a href="#bottom" onclick="makeEditableChl3(${ch})"><label class="button">EDIT</label></a></td>
                                                    <td id="save${ch}" style="display:none"><input  type="submit"  class="savebutton" value=""/></td>
                                                        <c:set var="user" value="${userid}"/>

                                                    <c:if test="${challan.createdBy==user}">
                                                        <td  id="del${ch}" style="display:none"><a href="<%=request.getContextPath()%>/deleteChallan?cons_no=${consumerDetail.consNo}&row_id=${challan.id}"  onclick="return confirmDel()"><label  class="delbutton">&nbsp;&nbsp;&nbsp;</label></a></td>
                                                    </c:if>

                                                    <%    if (userrole.equals("admin") || userrole.equals("manager")) {
                                                    %>
                                                    <td  id="del${ch}" style="display:none"><a href="<%=request.getContextPath()%>/deleteChallan?cons_no=${consumerDetail.consNo}&row_id=${challan.id}"  onclick="return confirmDel()"><label  class="delbutton">&nbsp;&nbsp;&nbsp;</label></a></td>

                                                    <c:if test="${!(challan.status=='A'||challan.status==null)}">

                                                        <td>  <a href="<%= request.getContextPath()%>/AuthoriseChallan?cons_no1=${challan.consNo}&id=${challan.id}">&nbsp;<label class="button">@</label></a></td>
                                                    </c:if>

                                                    <%                    }

                                                    %>

                                                </tr>
                                                <c:set var="ch" value="${ch + 1}"/></c:when>
                                            <c:otherwise>


                                                <tr>

                                                    <td><fmt:formatDate value="${challan.blPerFr}" pattern="dd/MM/yy"  var="blPerFr" /><input name="bl_per_fr" type="text"  size="5"  class="date"  value="${blPerFr}" readonly/></td>

                                                    <td><fmt:formatDate value="${challan.blPerTo}" pattern="dd/MM/yy"  var="blPerTo" /><input name="bl_per_to" type="text"   size="5"   class="date"  value="${blPerTo}" readonly/></td>

                                                    <td><fmt:formatDate value="${challan.dueDt}" pattern="dd/MM/yy"  var="dueDt" /><input name="due_dt" type="text"   size="5"   class="date"  value="${dueDt}" readonly/></td>

                                                    <td><input name="bill_amt" type="text"  size="5" value="${challan.billAmt}" class="number" readonly/></td>

                                                    <td><input name="surcharge" type="text"  size="4" value="${challan.surcharge}" class="number" readonly /></td>

                                                    <td><input name="paid_amt" type="text"  size="6" value="${challan.paidAmt}" class="required number" readonly/></td>

                                                    <td><fmt:formatDate value="${challan.payDate}" pattern="dd/MM/yy" var="payDate" /><input name="pay_date" type="text"   size="5"  value="${payDate}" class="required date" readonly/></td>

                                                    <td><input name="arrear" type="text"   size="4" value="${challan.arrear}" class="number"  readonly/></td>

                                                    <td><input type="text" name="credit"  size="4" value="${challan.credit}"  class="number" readonly /></td>

                                                    <td><input type="text" name="recp_no"  size="6"  value="${challan.recpNo}" maxlength="8" readonly/></td>

                                                    <td> <input name="dis_cd" type="text"  size="3" value="${challan.disCd}"  maxlength="1" readonly /></td>

                                                    <td><input name="noc" type="text"   size="3" value="${challan.noc}" class="number"  readonly/></td>

                                                    <td><input name="rmc" type="text"   size="3" value="${challan.rmc}" class="number"  readonly/></td>

                                                    <td><input name="chlsecu" type="text"  size="3"  value="${challan.secu}"  class="number"  readonly/></td>

                                                    <td><input name="t_fee" type="text"   size="3" value="${challan.TFee}" class="number" readonly/></td>

                                                    <td><input name="css" type="text"  size="3" value="${challan.css}" class="number" readonly/></td>

                                                    <td><input type="text" name="bnk_cd"  size="4" value="${challan.bnkCd}" readonly/></td>

                                                    <td><input name="br_nm" type="text"   size="4" value="${challan.brNm}" readonly/></td>


                                                    <td id="edit${ch}"  style="display:inline-block">  <a href="#bottom" onclick="makeEditableChl3(${ch})"><label class="button">EDIT</label></a></td>

                                                    <%    if (userrole.equals("admin") || userrole.equals("manager")) {
                                                    %>
                                                    <c:if test="${!(challan.status=='A'||challan.status==null)}">

                                                        <td>  <a href="<%= request.getContextPath()%>/AuthoriseChallan?cons_no1=${challan.consNo}&id=${challan.id}">&nbsp;<label class="button">@</label></a></td>
                                                    </c:if>

                                                    <%                    }

                                                    %>

                                                    <td id="save${ch}" style="display:none"><input  type="submit"  class="savebutton" value=""/></td>
                                                    <td  id="del${ch}" style="display:none"><a href="<%=request.getContextPath()%>/deleteChallan?cons_no=${consumerDetail.consNo}&row_id=${challan.id}"  onclick="return confirmDel()"><label  class="delbutton">&nbsp;&nbsp;&nbsp;</label></a></td>
                                                </tr>
                                                <c:set var="ch" value="${ch + 1}"/>
                                            </c:otherwise>
                                        </c:choose>

                                    </form>
                                </c:forEach>



                            </table>
                        </div>

                    </div>
                </div>
                <!-- Start bill listing -->
                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Old Bills</h3><a href="#Top"><img  alt="Top" src="<%=request.getContextPath()%>/NEWDMS/resources/images/icons/bottom.png"/></a>



                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">
                        <div>
                            <table   class="ed" cellspacing="0" cellpadding="0">
                                <thead>
                                    <tr>
                                        <th>Bill No.</th>
                                        <th>Bill From</th>
                                        <th>Bill To</th>

                                        <th>Rate</th>
                                        <th>Rebate</th>
                                        <th>Surcharge</th>
                                        <th>Security</th>
                                        <th>Transfer Fee</th>
                                        <th>NOC Fee</th>
                                        <th>Regular Fee</th>
                                        <th>Cess Amount</th>
                                        <th>Principal</th>
                                        <th>Interest</th>
                                        <th>Created By</th>
                                        <th>Created Date</th>
                                    </tr>
                                </thead>




                                <c:forEach var="bill" items="${billList}">
                                    <form    name="bill" method="post" action="<%=request.getContextPath()%>/printBill">

                                        <input type="hidden" name="cons_no1"  value="${bill.consNo}"/>

                                        <tr>
                                            <td><input name="bill_no" type="text"  size="5" value="${bill.id}" class="number" readonly/></td>
                                            <td><fmt:formatDate value="${bill.billFrom}" pattern="dd/MM/yy"  var="billFrom" /><input  type="text"  size="5"  class="date"  value="${billFrom}" readonly/></td>

                                            <td><fmt:formatDate value="${bill.billTo}" pattern="dd/MM/yy"  var="billTo" /><input type="text"   size="5"   class="date"  value="${billTo}" readonly/></td>



                                            <td><input  type="text"  size="5" value="${bill.rate}" class="number" readonly /></td>

                                            <td><input  type="text"  size="5" value="${bill.rebate}" class="number" readonly/></td>



                                            <td><input  type="text"   size="5" value="${bill.surcharge}" class="number"  readonly/></td>

                                            <td><input type="text"   size="5" value="${bill.security}"  class="number" readonly /></td>

                                            <td><input type="text"   size="5"  value="${bill.TFee}"  class="number" readonly/></td>

                                            <td> <input  type="text"  size="5" value="${bill.nocFee}"   class="number" readonly /></td>

                                            <td><input type="text"   size="5" value="${bill.regularFee}" class="number"  readonly/></td>

                                            <td><input type="text"   size="5" value="${bill.cessAmount}" class="number"  readonly/></td>

                                            <td><input type="text"  size="6"  value="${bill.principal}"  class="number"  readonly/></td>

                                            <td><input  type="text"   size="6" value="${bill.interest}" class="number" readonly/></td>



                                            <td><input type="text"   size="6" value="${bill.createBy}" readonly/></td>

                                            <td><fmt:formatDate value="${bill.createdDate}" pattern="dd/MM/yy"  var="createdDate" /><input type="text"   size="5" value="${createdDate}" readonly/></td>


                                            <td style="display:inline-block">  <a href="<%=request.getContextPath()%>/printBill?billNo=${bill.id}" ><label class="button">PRINT</label></a></td>

                                        </tr>

                                    </form>
                                </c:forEach>



                            </table>
                        </div>

                    </div>
                </div>

                <!-- End bill listing -->

                <div class="content-box"><!-- Start Content Box -->
                    <div class="content-box-header">
                        <h3>Bill Generation</h3>

                        <div class="clear"></div>

                    </div> <!-- End .content-box-header -->

                    <div class="content-box-content">
                        <div>
                            <form name="newbill" id="newbill"  action="<%= request.getContextPath()%>/CalculateBillForConsumer" onsubmit="return checkBillGeneration()">

                                <table>

                                    <td>
                                        <p>
                                            <label class="form-label">Consumer No</label>
                                            <input type="text" name="cons_no" id="cons_no" class="required" value="${consumerDetail.consNo}"  readonly  />
                                            <label id="lcons_no" class="error" style="visibility:hidden" >Enter existing consumer.</label>
                                        </p>
                                        <p>
                                            <label class="form-label">Bill To</label>
                                            <input type="text" name="bill_to" id="bill_to" onblur="checkbilltodate(); checkMst()"  onkeyup="clearUserID()" class="required date"/>
                                            <label id="ctodate" class="error" style="visibility:hidden" >Can't before financial year.</label>
                                        </p>
                                        <p>
                                            <label class="form-label">Due Date</label>
                                            <input type="text" name="duedate" id="duedate" onblur="checkduedate(id);" class="required date"/>
                                            <label id="cduedate" class="error" style="visibility:hidden" >Can't before current date.</label>
                                            <input type="hidden" id="billFlag" name="billFlag" value="1"/>
                                        </p></td>

                                    <td>
                                        <c:if test="${after1990 eq 0}">
                                            <p>
                                                <label class="form-label">Arrear Before 1990</label>
                                                <input type="text" class="required" disabled/>
                                            </p>
                                            <p id="upto">
                                                <label class="form-label">Arrear Up To</label>
                                                <input type="text"   class="required date" disabled/>
                                            </p>
                                        </c:if>
                                        <c:if test="${after1990 eq 1}">
                                            <p>
                                                <label class="form-label">Arrear Before 1990</label>
                                                <input type="text" name="arrear" id="arrear" class="required" />
                                            </p>
                                            <p id="upto">
                                                <label class="form-label">Arrear Up To</label>
                                                <input type="text" name="arrearupto" id="arrearupto"  class="required date" />
                                            </p>
                                        </c:if>
                                        <div id="wait" style="display: none"  >
                                            <img src="<%=request.getContextPath()%>/NEWDMS/resources/images/ajax-loader.gif" alt="wait"   /><p style="font-weight: bold;" > Calculating Bill</p>
                                        </div>
                                    </td>
                                </table>
                                <p>

                                    <input type="checkbox" name="transfer" id="transfer" />
                                    <label class="form-label">Name Transfer</label>

                                    <input type="checkbox" name="noc" id="noc" />
                                    <label class="form-label">NOC</label>
                                    <input type="checkbox" name="regular" id="regular" />
                                    <label class="form-label">Temprary-Regular</label>
                                </p>

                                <input type="submit"  id="billId" class="button" value="GENERATE BILL"/>


                            </form>
                            <form action="<%= request.getContextPath()%>/getBillPdf"  onsubmit="cancel2()" >

                                <input type="submit"  id="getPdf" class="button" style="display: none" value="GET PDF"/>
                                <input type="button"  id="cancel" class="button" style="display: none"   value="CANCEL" onclick="cancel1()"/>
                            </form>
                        </div>
                    </div>


                </div>


            </div>
            <jsp:include page="../common/footer.jsp"/>
        </div>

    </body>
</html>
