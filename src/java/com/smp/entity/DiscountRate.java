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
@Table(name = "DISCOUNT_RATE")
@NamedQueries({

    @NamedQuery(name = "DiscountRate.findByDateBetween", query = "SELECT d FROM DiscountRate d WHERE d.dateFrom <= :dateFrom and d.dateTo >= :dateTo"),
    @NamedQuery(name = "DiscountRate.findAll", query = "SELECT d FROM DiscountRate d"),
    @NamedQuery(name = "DiscountRate.findByMaxId", query = "SELECT  MAX(d.id) FROM DiscountRate d"),
    @NamedQuery(name = "DiscountRate.findById", query = "SELECT d FROM DiscountRate d WHERE d.id = :id"),
    @NamedQuery(name = "DiscountRate.findByDateFrom", query = "SELECT d FROM DiscountRate d WHERE d.dateFrom = :dateFrom"),
    @NamedQuery(name = "DiscountRate.findByDateTo", query = "SELECT d FROM DiscountRate d WHERE d.dateTo = :dateTo"),
    @NamedQuery(name = "DiscountRate.findByRate", query = "SELECT d FROM DiscountRate d WHERE d.rate = :rate")})
public class DiscountRate implements Serializable {

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

    public DiscountRate() {
    }

    public DiscountRate(BigDecimal id) {
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DiscountRate)) {
            return false;
        }
        DiscountRate other = (DiscountRate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.DiscountRate[id=" + id + "]";
    }
}
