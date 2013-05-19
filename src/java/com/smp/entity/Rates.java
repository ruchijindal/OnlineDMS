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
@Table(name = "RATES")
@NamedQueries({
    @NamedQuery(name = "Rates.findByCriteriaForFlat", query = "SELECT r FROM Rates r WHERE  (r.connType = :connType) and (r.dateFrom < :dateFrom and r.dateTo > :dateTo) and (r.connCategory = :connCategory) and (r.sector = :sector) and (r.flatType =  :flatType)"),
    @NamedQuery(name = "Rates.findByCriteriaForBulk", query = "SELECT r FROM Rates r WHERE (r.pipeSize = :pipeSize) and (r.connType = :connType) and (r.dateFrom < :dateFrom and r.dateTo > :dateTo) and (r.connCategory = :connCategory) "),
    @NamedQuery(name = "Rates.findByCriteria", query = "SELECT r FROM Rates r WHERE (r.pipeSize = :pipeSize) and (r.connType = :connType) and (r.dateFrom < :dateFrom and r.dateTo > :dateTo) and (r.connCategory = :connCategory) and (r.minPlotSize < :minPlotSize and r.maxPlotSize > :maxPlotSize)"),
    @NamedQuery(name = "Rates.findAll", query = "SELECT r FROM Rates r ORDER BY r.id"),
    @NamedQuery(name = "Rates.findByMaxId", query = "SELECT MAX(r.id) FROM Rates r "),
    @NamedQuery(name = "Rates.findById", query = "SELECT r FROM Rates r WHERE r.id = :id "),
    @NamedQuery(name = "Rates.findByConnType", query = "SELECT r FROM Rates r WHERE r.connType = :connType"),
    @NamedQuery(name = "Rates.findByConnCategory", query = "SELECT r FROM Rates r WHERE r.connCategory = :connCategory"),
    @NamedQuery(name = "Rates.findByDateFrom", query = "SELECT r FROM Rates r WHERE r.dateFrom = :dateFrom"),
    @NamedQuery(name = "Rates.findByDateTo", query = "SELECT r FROM Rates r WHERE r.dateTo = :dateTo"),
    @NamedQuery(name = "Rates.findByMinPlotSize", query = "SELECT r FROM Rates r WHERE r.minPlotSize = :minPlotSize"),
    @NamedQuery(name = "Rates.findByMaxPlotSize", query = "SELECT r FROM Rates r WHERE r.maxPlotSize = :maxPlotSize"),
    @NamedQuery(name = "Rates.findByPipeSize", query = "SELECT r FROM Rates r WHERE r.pipeSize = :pipeSize"),
    @NamedQuery(name = "Rates.findByRate", query = "SELECT r FROM Rates r WHERE r.rate = :rate"),
    @NamedQuery(name = "Rates.findByFlatType", query = "SELECT r FROM Rates r WHERE r.flatType = :flatType"),
    @NamedQuery(name = "Rates.findBySector", query = "SELECT r FROM Rates r WHERE r.sector = :sector"),
    @NamedQuery(name = "Rates.findBySelectedValues", query = "SELECT r FROM Rates r WHERE (:connType is null or  r.connType = :connType) and (:connCategory is null or r.connCategory = :connCategory)and (:flatType is null or r.flatType = :flatType)and (:sector is null or r.sector = :sector) and (:dateFrom is null or r.dateFrom >= :dateFrom)  and (:maxPlotSize is null or r.minPlotSize <= :maxPlotSize and r.maxPlotSize >= :maxPlotSize)  and (:pipeSize is null or r.pipeSize = :pipeSize) ORDER BY r.connType, r.connCategory,r.pipeSize,r.minPlotSize,r.maxPlotSize, r.dateFrom"),
    @NamedQuery(name = "Rates.findByConnTypeAndConnCategory", query = "SELECT r FROM Rates r WHERE r.connType = :connType AND r.connCategory = :connCategory"),
    @NamedQuery(name = "Rates.findByConnTypeAndConnCategoryAndDateFrom", query = "SELECT r FROM Rates r WHERE r.connType = :connType AND r.connCategory = :connCategory AND r.dateFrom = :dateFrom"),
    @NamedQuery(name = "Rates.findByConnCategoryAndDateFrom", query = "SELECT r FROM Rates r WHERE r.connCategory = :connCategory And r.dateFrom = :dateFrom")})
public class Rates implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    private BigDecimal id;
    @Column(name = "CONN_TYPE")
    private String connType;
    @Column(name = "CONN_CATEGORY")
    private String connCategory;
    @Column(name = "DATE_FROM")
    @Temporal(TemporalType.DATE)
    private Date dateFrom;
    @Column(name = "DATE_TO")
    @Temporal(TemporalType.DATE)
    private Date dateTo;
    @Column(name = "MIN_PLOT_SIZE")
    private BigInteger minPlotSize;
    @Column(name = "MAX_PLOT_SIZE")
    private BigInteger maxPlotSize;
    @Column(name = "PIPE_SIZE")
    private BigInteger pipeSize;
    @Column(name = "RATE")
    private Double rate;
    @Column(name = "FLAT_TYPE")
    private String flatType;
    @Column(name = "SECTOR")
    private String sector;

    public Rates() {
    }

    public Rates(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getConnType() {
        return connType;
    }

    public void setConnType(String connType) {
        this.connType = connType;
    }

    public String getConnCategory() {
        return connCategory;
    }

    public void setConnCategory(String connCategory) {
        this.connCategory = connCategory;
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

    public BigInteger getMinPlotSize() {
        return minPlotSize;
    }

    public void setMinPlotSize(BigInteger minPlotSize) {
        this.minPlotSize = minPlotSize;
    }

    public BigInteger getMaxPlotSize() {
        return maxPlotSize;
    }

    public void setMaxPlotSize(BigInteger maxPlotSize) {
        this.maxPlotSize = maxPlotSize;
    }

    public BigInteger getPipeSize() {
        return pipeSize;
    }

    public void setPipeSize(BigInteger pipeSize) {
        this.pipeSize = pipeSize;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public String getFlatType() {
        return flatType;
    }

    public void setFlatType(String flatType) {
        this.flatType = flatType;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
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
        if (!(object instanceof Rates)) {
            return false;
        }
        Rates other = (Rates) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.Rates[id=" + id + "]";
    }
}
