/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
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
 * @author smp
 */
@Entity
@Table(name = "CESS_RATE")
@NamedQueries({
     @NamedQuery(name = "CessRate.findByPipeSize&connType&Date", query = "SELECT c FROM CessRate c where c.pipeSize = :pipeSize and c.conType like :conType and c.dateFrom <= :dateFrom and c.dateTo >= :dateTo"),
    @NamedQuery(name = "CessRate.findAll", query = "SELECT c FROM CessRate c"),
    @NamedQuery(name = "CessRate.findById", query = "SELECT c FROM CessRate c WHERE c.id = :id"),
    @NamedQuery(name = "CessRate.findByConType", query = "SELECT c FROM CessRate c WHERE c.conType = :conType"),
    @NamedQuery(name = "CessRate.findByDateFrom", query = "SELECT c FROM CessRate c WHERE c.dateFrom = :dateFrom"),
    @NamedQuery(name = "CessRate.findBypipeSize", query = "SELECT c FROM CessRate c WHERE c.pipeSize = :pipeSize"),
    @NamedQuery(name = "CessRate.findByDateTo", query = "SELECT c FROM CessRate c WHERE c.dateTo = :dateTo"),
    @NamedQuery(name = "CessRate.findByRate", query = "SELECT c FROM CessRate c WHERE c.rate = :rate"),
     @NamedQuery(name = "CessRate.findByMaxId", query = "SELECT MAX(c.id) FROM CessRate c ")})
public class CessRate implements Serializable {

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
    @Column(name = "CON_TYPE")
    private String conType;
    @Column(name = "PIPE_SIZE")
    private BigInteger pipeSize;

    public CessRate() {
    }

    public CessRate(BigDecimal id) {
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

    public String getConType() {
        return conType;
    }

    public void setConType(String conType) {
        this.conType = conType;
    }

    public BigInteger getPipeSize() {
        return pipeSize;
    }

    public void setPipeSize(BigInteger pipeSize) {
        this.pipeSize = pipeSize;
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
        if (!(object instanceof CessRate)) {
            return false;
        }
        CessRate other = (CessRate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.CessRate[id=" + id + "]";
    }
}
