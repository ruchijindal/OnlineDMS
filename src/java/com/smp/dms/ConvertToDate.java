/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.dms;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author smp
 */
public class ConvertToDate {

   
    DateFormat formatter;
    java.sql.Date sqldt = null;
    java.util.Date utildt = null;

    public java.sql.Date convertStringToDate(String strdt) {

        formatter = new SimpleDateFormat("dd/MM/yy");
        try {
            utildt = (java.util.Date) formatter.parse(strdt);
        } catch (ParseException ex) {
            System.out.println("Exception in ConvertToDate:" + ex);
        }
        sqldt = new java.sql.Date(utildt.getTime());

        return sqldt;
    }

    public Calendar convertStringToCLDate(String strdt) {
        Calendar dt = Calendar.getInstance();
        formatter = new SimpleDateFormat("dd/MM/yy");
        try {
            utildt = (java.util.Date) formatter.parse(strdt);
        } catch (ParseException ex) {
            System.out.println("Exception in ConvertToDate:" + ex);
        }
        dt.setTimeInMillis(utildt.getTime());
        return dt;
    }
}
