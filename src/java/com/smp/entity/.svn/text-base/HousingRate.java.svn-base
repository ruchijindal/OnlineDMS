/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author smp-06
 */
@Entity
@Table(name = "HOUSING_RATE")
@NamedQueries({
    @NamedQuery(name = "HousingRate.findByCriteria", query = "SELECT h FROM HousingRate h WHERE h.consNo = :consNo and (h.dateFrom <= :dateFrom and h.dateTo >= :dateTo)"),
    @NamedQuery(name = "HousingRate.findAll", query = "SELECT h FROM HousingRate h"),
    @NamedQuery(name = "HousingRate.findById", query = "SELECT h FROM HousingRate h WHERE h.id = :id"),
    @NamedQuery(name = "HousingRate.findByMaxId", query = "SELECT MAX(h.id) FROM HousingRate h"),
    @NamedQuery(name = "HousingRate.findByDateFrom", query = "SELECT h FROM HousingRate h WHERE h.dateFrom = :dateFrom"),
    @NamedQuery(name = "HousingRate.findByDateTo", query = "SELECT h FROM HousingRate h WHERE h.dateTo = :dateTo"),
    @NamedQuery(name = "HousingRate.findByRate", query = "SELECT h FROM HousingRate h WHERE h.rate = :rate"),
    @NamedQuery(name = "HousingRate.findByConsNo", query = "SELECT h FROM HousingRate h WHERE h.consNo = :consNo")})
public class HousingRate implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    private BigDecimal id;
    @Column(name = "DATE_FROM")
    @Temporal(TemporalType.DATE)
    private Date dateFrom;
    @Column(name = "DATE_TO")
    @Temporal(TemporalType.DATE)
    private Date dateTo;
    @Column(name = "RATE")
    private Double rate;
    @Column(name = "CONS_NO")
    private String consNo;

    public HousingRate() {
    }

    public HousingRate(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public Date getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(Date dateFrom) {
        this.dateFrom = dateFrom;
    }

    public Date getDateTo() {
        return dateTo;
    }

    public void setDateTo(Date dateTo) {
        this.dateTo = dateTo;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public String getConsNo() {
        return consNo;
    }

    public void setConsNo(String consNo) {
        this.consNo = consNo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof HousingRate)) {
            return false;
        }
        HousingRate other = (HousingRate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.HousingRate[id=" + id + "]";
    }

}
