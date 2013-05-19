/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author smp-06
 */
public interface Sewerdetails {
     public String getConsNo();

    public void setConsNo(String consNo) ;

    public String getSRegNo();

    public void setSRegNo(String sRegNo);

    public Date getSConDt();

    public void setSConDt(Date sConDt);

    public String getSEstNo();

    public void setSEstNo(String sEstNo);

    public Integer getSEstAmt();

    public void setSEstAmt(Integer sEstAmt) ;

    public Integer getSSecu() ;

    public void setSSecu(Integer sSecu) ;
    public Integer getSEstPamt() ;

    public void setSEstPamt(Integer sEstPamt) ;

    public Date getSEstPdate() ;

    public void setSEstPdate(Date sEstPdate) ;
    public Date getSNodueDt() ;

    public void setSNodueDt(Date sNodueDt) ;

    public Integer getSNodueAmt() ;

    public void setSNodueAmt(Integer sNodueAmt) ;
      public String getCreatedBy();

    public void setCreatedBy(String createdBy);

    public Date getCreatedDate();

    public void setCreatedDate(Date createdDate);

    public String getEditedBy() ;

    public void setEditedBy(String editedBy);

    public Date getEditedDate();

    public void setEditedDate(Date editedDate) ;

    public Double getId();

    public void setId(Double id) ;


}
