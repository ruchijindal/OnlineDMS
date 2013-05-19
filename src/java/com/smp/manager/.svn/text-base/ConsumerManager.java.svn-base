/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.manager;

import com.smp.entity.Master;
import com.smp.entity.Master1;
import com.smp.entity.Master2;
import com.smp.entity.Master3;
import com.smp.entity.Sewerdetails;
import com.smp.entity.Sewerdetails1;
import com.smp.entity.Sewerdetails2;
import com.smp.entity.Sewerdetails3;
import com.smp.session.Master1Facade;
import com.smp.session.Master2Facade;
import com.smp.session.Master3Facade;
import com.smp.session.Sewerdetails1Facade;
import com.smp.session.Sewerdetails2Facade;
import com.smp.session.Sewerdetails3Facade;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.jms.Session;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author smp
 */
@Stateless
public class ConsumerManager {

    @EJB
    Master1Facade master1Facade;
    @EJB
    Master2Facade master2Facade;
    @EJB
    Master3Facade master3Facade;
    @EJB
    Sewerdetails1Facade sewerdetails1Facade;
    @EJB
    Sewerdetails2Facade sewerdetails2Facade;
    @EJB
    Sewerdetails3Facade sewerdetails3Facade;
    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    public Master master = null;
    public Sewerdetails sewerdetails = null;
    DateFormat formatter;
    BigDecimal id;
    Double id1;
   // long id1;
    BigDecimal id2;
             // setConsumerDetail(       division,        cons_no,        sector,        cons_nm1,        cons_nm2,        con_tp,        cons_ctg,        flat_type,        flat_no,        blk_no,        plot_size,     pipe_size,        reg_no,        conn_dt,        esti_no,        esti_amt,        secu,       esti_dt,         esti1_amt,        nodue_amt,        nodue_dt,        pos_dt,        comp_dt,       trans_nm,         trf,        cal_date,     createdBy,     createdDate);
    public void setConsumerDetail(String division, String cons_no, String sector, String cons_nm1, String cons_nm2, String con_tp, String cons_ctg, String flat_type, String flat_no, String blk_no, double plot_size, int pipe_size, String reg_no, String conn_dt, String esti_no, double esti_amt, double secu, String esti_dt, double esti1_amt, double nodue_amt, String nodue_dt, String pos_dt, String comp_dt, String trans_nm, String trf, String cal_dt,String createdBy,Date createdDate,String userRole) {

        try {
            System.out.println("DIVISION...." + division);
             System.out.println("sector...." + sector);
            Query maxId = em.createNamedQuery("Master" + division + ".findByMaxId");
            id = (BigDecimal) maxId.getResultList().get(0);
            System.out.println("ID...." + id);

            if (division.equals("1")) {
                master = new Master1();
            } else if (division.equals("2")) {
                master = new Master2();
            } else {
                master = new Master3();
            }
            
            if (id != null) {
                master.setId(BigDecimal.valueOf(id.intValue() + 1));
            } else {
                master.setId(BigDecimal.valueOf(1));
            }
            formatter = new SimpleDateFormat("dd/MM/yy");

            master.setConsNo(cons_no);
            master.setConsNm1(cons_nm1);
            master.setConsNm2(cons_nm2);
            master.setConTp(con_tp);
            master.setConsCtg(cons_ctg);
            master.setBlkNo(blk_no);
            if (comp_dt.equals("null")) {
                master.setCompDate(null);
            } else {
                master.setCompDate((Date) formatter.parse(comp_dt));
            }
            if (cal_dt.equals("null")) {
                master.setCalDate(null);
            } else {
                master.setCalDate((Date) formatter.parse(cal_dt));
            }
            if(nodue_dt.equals("null"))
            {
                master.setNodueDt(null);
            }else{
                master.setNodueDt((Date)formatter.parse(nodue_dt));
            }
            if(pos_dt.equals("null"))
            {
                master.setPosDate(null);
            }else{
                master.setPosDate((Date)formatter.parse(pos_dt));
            }
            master.setEsti1Amt(BigDecimal.valueOf(esti1_amt));
            master.setEstiAmt(BigDecimal.valueOf(esti_amt));
            master.setSecu(BigDecimal.valueOf(secu));
            if (esti_dt.equals("null")) {
                master.setEstiDt(null);
            } else {
                master.setEstiDt((Date) formatter.parse(esti_dt));
            }
            master.setEstiNo(esti_no);
            master.setFlatNo(flat_no);
            master.setFlatType(flat_type);
            master.setNodueAmt(BigDecimal.valueOf(nodue_amt));
            master.setPipeSize(BigDecimal.valueOf(pipe_size));
            master.setPlotSize(BigDecimal.valueOf(plot_size));
            master.setRegNo(reg_no);
            master.setSector(sector);
            master.setTransNm(trans_nm);
           // master.setTrf(trf);
          master.setCreatedBy(createdBy);
          if(userRole.equals("employee"))
          {
              master.setStatus("UA");
          }else{
              master.setStatus("A");
              master.setAuthoriseBy(createdBy);
              master.setAuthorizedDate(createdDate);
          }
          
          master.setCreatedDate(createdDate);
            if (conn_dt.equals("null")) {
                master.setConnDt(null);
            } else {
                master.setConnDt((Date) formatter.parse(conn_dt));
            }
            if (division.equals("1")) {
                master1Facade.create((Master1) master);
            } else if (division.equals("2")) {
                master2Facade.create((Master2) master);
            }
            if (division.equals("3")) {
                master3Facade.create((Master3) master);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

    }
//consumerManager.setSewerDetail(     division,         cons_no,       s_reg_no,        s_con_dt,        s_est_no,     s_est_amt,     s_secu,        s_est_pdt,     s_est_pamt,     s_nodue_amt,        s_nodue_dt,       createdBy,     createdDate);
    public void setSewerDetail(String division, String cons_no, String s_reg_no, String s_con_dt, String s_est_no, int s_est_amt, int s_secu, String s_est_pdt, int s_est_pamt, int s_nodue_amt, String s_nodue_dt,String createdBy,Date createdDate) {
        try {
        if(division.equals("1"))
            sewerdetails=new Sewerdetails1();
        else if(division.equals("2"))
            sewerdetails=new Sewerdetails2();
        else
            sewerdetails=new Sewerdetails3();

         Query maxId = em.createNamedQuery("Sewerdetails" + division + ".findByMaxId");
            id1 = (Double) maxId.getResultList().get(0);
            System.out.println("ID...." + id);

             if (id != null) {
                sewerdetails.setId(id.doubleValue() + 1);
            } else {
                sewerdetails.setId(Double.valueOf("1"));
            }
            sewerdetails.setConsNo(cons_no);
            if (s_con_dt.equals("null")) {
                sewerdetails.setSConDt(null);
            } else {
                sewerdetails.setSConDt((Date) formatter.parse(s_con_dt));
            }
            sewerdetails.setSEstAmt(s_est_amt);
            sewerdetails.setSEstNo(s_est_no);
            sewerdetails.setSEstPamt(s_est_pamt);
            sewerdetails.setCreatedBy(createdBy);
            sewerdetails.setCreatedDate(createdDate);
            if (s_est_pdt.equals("null")) {
                sewerdetails.setSEstPdate(null);
            } else {
                sewerdetails.setSEstPdate((Date) formatter.parse(s_est_pdt));
            }
            sewerdetails.setSNodueAmt(s_nodue_amt);
            if (s_nodue_dt.equals("null")) {
                sewerdetails.setSNodueDt(null);
            } else {
                sewerdetails.setSNodueDt((Date) formatter.parse(s_nodue_dt));
            }
            sewerdetails.setSRegNo(s_reg_no);
            sewerdetails.setSSecu(s_secu);
            if (division.equals("1")) {
                sewerdetails1Facade.create((Sewerdetails1) sewerdetails);
            } else if (division.equals("2")) {
                sewerdetails2Facade.create((Sewerdetails2) sewerdetails);
            } else if (division.equals("3")) {
                sewerdetails3Facade.create((Sewerdetails3) sewerdetails);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

    }
}
