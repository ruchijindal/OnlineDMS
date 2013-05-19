/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author smp-06
 */
@Entity
@Table(name = "INTEREST_RATES")
@NamedQueries({
    @NamedQuery(name = "InterestRates.findByDateBetween", query = "SELECT i FROM InterestRates i WHERE i.dateFrom <= :dateFrom and i.dateTo >= :dateTo"),
    @NamedQuery(name = "InterestRates.findAll", query = "SELECT i FROM InterestRates i"),
    @NamedQuery(name = "InterestRates.findById", query = "SELECT i FROM InterestRates i WHERE i.id = :id"),
    @NamedQuery(name = "InterestRates.findByDateFrom", query = "SELECT i FROM InterestRates i WHERE i.dateFrom = :dateFrom"),
    @NamedQuery(name = "InterestRates.findByDateTo", query = "SELECT i FROM InterestRates i WHERE i.dateTo = :dateTo"),
    @NamedQuery(name = "InterestRates.findByRate", query = "SELECT i FROM InterestRates i WHERE i.rate = :rate"),
    @NamedQuery(name = "InterestRates.findByMaxId", query = "SELECT MAX(i.id) FROM InterestRates i ")})
public class InterestRates implements Serializable {

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

    public InterestRates() {
    }

    public InterestRates(BigDecimal id) {
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
        if (!(object instanceof InterestRates)) {
            return false;
        }
        InterestRates other = (InterestRates) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.InterestRates[id=" + id + "]";
    }
}
