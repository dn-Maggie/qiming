package com.dongnao.workbench.account.model;

import java.util.Date;
import java.math.BigDecimal;
import org.springframework.format.annotation.DateTimeFormat;
import com.dongnao.workbench.common.bean.Model;
/**
 * 描述：会计凭证管理模块实体类，负责页面与后台数据传输功能
 *
 * @author maggie
 * @version 1.0 2016-08-15
 */
public class Accounting extends Model{
	
	
		            /**
	                 * 自动编号录入
	                 **/
				   			private String id;
		   		
		            /**
	                 * 凭证类别 字
	                 **/
				   			private String documentType;
		   		
		            /**
	                 * 凭证类别排序号
	                 **/
				   			private Integer documentNo;
		   		
		            /**
	                 * 会计期间
	                 **/
					@DateTimeFormat(pattern="yyyy-MM-dd") 
			private Date accountPeriod;
		
		            /**
	                 * 制单日期
	                 **/
					@DateTimeFormat(pattern="yyyy-MM-dd") 
			private Date billDate;
		
		            /**
	                 * 制单人编号
	                 **/
				   			private String enterPno;
				   		 /**
			                 * 制单人编号
			                 **/
						   			private String enterPname;
		   		
		            /**
	                 * 审核人编号
	                 **/
				   			private String checkPno;
		   		
		            /**
	                 * 记账人编号
	                 **/
				   			private String bookPno;
		   		
		            /**
	                 * 附单据数量
	                 **/
				   			private String docAttach;
		   		
		            /**
	                 * 凭证有效标志 0_有效凭证，1_作废凭证，2_有错凭证(作废凭证可取消作废/进行凭证整理) 
	                 **/
				   			private Integer validFlag;
		   		
		            /**
	                 * 记账标志 1_已记账 0_未记账
	                 **/
				   			private Integer bookFlag;
				   			/**
			                 * 审核标志 1_已审核0_未审核
			                 **/
						   			private Integer checkFlag;
		   		
		            /**
	                 * 摘要
	                 **/
				   			private String digest;
		   		
		            /**
	                 * 币种
	                 **/
				   			private String exchName;
		   		
		            
		   		
		            /**
	                 * 借方科目名称
	                 **/
				   			private String mdName;
		   		
		            /**
	                 * 借方金额
	                 **/
				   			private String mdMoney;
		   		
		            /**
	                 * 借方数量 若无数量,写0
	                 **/
				   			private String mdNum;
		   		
		           
		            /**
	                 * 贷方科目名称
	                 **/
				   			private String mcName;
		   		
		            /**
	                 * 贷方金额
	                 **/
				   			private String mcMoney;
		   		
		            /**
	                 * 贷方数量 若无数量,写0
	                 **/
				   			private String mcNum;
		   		
		            /**
	                 * 结算方式 结算方式有 现金，支票，现金支票，转账支票，银行汇票，商业汇票
	                 **/
				   			private String settleType;
		   		
		            /**
	                 * 支(汇)票号
	                 **/
				   			private String chequeNo;
		   		
		            /**
	                 * 票号发生日期
	                 **/
					@DateTimeFormat(pattern="yyyy-MM-dd") 
			private Date chequeDate;
		
		            /**
	                 * 发生时间
	                 **/
					@DateTimeFormat(pattern="yyyy-MM-dd") 
			private Date createDate;
		
		            /**
	                 * 发生额
	                 **/
				   			private String money;
		   		
		            /**
	                 * 部门编码
	                 **/
				   			private String deptNo;
		   		
		            /**
	                 * 职员编码
	                 **/
				   			private String empNo;
		   		
		            /**
	                 * 客户编码
	                 **/
				   			private String custoNo;
		   		
		            /**
	                 * 供应商编码
	                 **/
				   			private String applyNo;
		   		
		            /**
	                 * 业务员编码
	                 **/
				   			private String salesmanNo;
		   		
		            /**
	                 * 备注
	                 **/
				   			private String note;
		   		
	
				
		  			/**
			 * 获取 自动编号录入
			 * @return String this.id
			 */
			public String getId(){
				return this.id;
			}
			
			/**
			 * 设置 自动编号录入
			 * @param String id 
			 */
			public void setId(String id){
				this.id = id;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 凭证类别 字
			 * @return String this.documentType
			 */
			public String getDocumentType(){
				return this.documentType;
			}
			
			/**
			 * 设置 凭证类别 字
			 * @param String documentType 
			 */
			public void setDocumentType(String documentType){
				this.documentType = documentType;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 凭证类别排序号
			 * @return Integer this.documentNo
			 */
			public Integer getDocumentNo(){
				return this.documentNo;
			}
			
			/**
			 * 设置 凭证类别排序号
			 * @param BigDecimal documentNo 
			 */
			public void setDocumentNo(Integer documentNo){
				this.documentNo = documentNo;
			}
		  		
		
		
			
								/**
			 * 获取 会计期间
			 * @return Date this.accountPeriod
			 */
			public Date getAccountPeriod(){
				return this.accountPeriod;
			}
			
			/**
			 * 设置 会计期间
			 * @param Date accountPeriod 
			 */
			public void setAccountPeriod(Date accountPeriod){
				this.accountPeriod = accountPeriod;
			}
								/**
			 * 获取 制单日期
			 * @return Date this.billDate
			 */
			public Date getBillDate(){
				return this.billDate;
			}
			
			/**
			 * 设置 制单日期
			 * @param Date billDate 
			 */
			public void setBillDate(Date billDate){
				this.billDate = billDate;
			}
						
		  			/**
			 * 获取 制单人编号
			 * @return String this.enterPno
			 */
			public String getEnterPno(){
				return this.enterPno;
			}
			
			/**
			 * 设置 制单人编号
			 * @param String enterPno 
			 */
			public void setEnterPno(String enterPno){
				this.enterPno = enterPno;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 审核人编号
			 * @return String this.checkPno
			 */
			public String getCheckPno(){
				return this.checkPno;
			}
			
			/**
			 * 设置 审核人编号
			 * @param String checkPno 
			 */
			public void setCheckPno(String checkPno){
				this.checkPno = checkPno;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 记账人编号
			 * @return String this.bookPno
			 */
			public String getBookPno(){
				return this.bookPno;
			}
			
			/**
			 * 设置 记账人编号
			 * @param String bookPno 
			 */
			public void setBookPno(String bookPno){
				this.bookPno = bookPno;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 附单据数量
			 * @return String this.docAttach
			 */
			public String getDocAttach(){
				return this.docAttach;
			}
			
			/**
			 * 设置 附单据数量
			 * @param String docAttach 
			 */
			public void setDocAttach(String docAttach){
				this.docAttach = docAttach;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 凭证有效标志 0_有效凭证，1_作废凭证，2_有错凭证(作废凭证可取消作废/进行凭证整理) 
			 * @return Integer this.validFlag
			 */
			public Integer getValidFlag(){
				return this.validFlag;
			}
			
			/**
			 * 设置 凭证有效标志 0_有效凭证，1_作废凭证，2_有错凭证(作废凭证可取消作废/进行凭证整理) 
			 * @param BigDecimal validFlag 
			 */
			public void setValidFlag(Integer validFlag){
				this.validFlag = validFlag;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 记账标志 1_已记账 0_未记账
			 * @return Integer this.bookFlag
			 */
			public Integer getBookFlag(){
				return this.bookFlag;
			}
			
			/**
			 * 设置 记账标志 1_已记账 0_未记账
			 * @param BigDecimal bookFlag 
			 */
			public void setBookFlag(Integer bookFlag){
				this.bookFlag = bookFlag;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 摘要
			 * @return String this.digest
			 */
			public String getDigest(){
				return this.digest;
			}
			
			/**
			 * 设置 摘要
			 * @param String digest 
			 */
			public void setDigest(String digest){
				this.digest = digest;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 币种
			 * @return String this.exchName
			 */
			public String getExchName(){
				return this.exchName;
			}
			
			/**
			 * 设置 币种
			 * @param String exchName 
			 */
			public void setExchName(String exchName){
				this.exchName = exchName;
			}
		   		
			
						
		  			/**
			 * 获取 借方科目名称
			 * @return String this.mdName
			 */
			public String getMdName(){
				return this.mdName;
			}
			
			/**
			 * 设置 借方科目名称
			 * @param String mdName 
			 */
			public void setMdName(String mdName){
				this.mdName = mdName;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 借方金额
			 * @return String this.mdMoney
			 */
			public String getMdMoney(){
				return this.mdMoney;
			}
			
			/**
			 * 设置 借方金额
			 * @param String mdMoney 
			 */
			public void setMdMoney(String mdMoney){
				this.mdMoney = mdMoney;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 借方数量 若无数量,写0
			 * @return String this.mdNum
			 */
			public String getMdNum(){
				return this.mdNum;
			}
			
			/**
			 * 设置 借方数量 若无数量,写0
			 * @param String mdNum 
			 */
			public void setMdNum(String mdNum){
				this.mdNum = mdNum;
			}
		   		
						
		  			/**
			 * 获取 贷方科目名称
			 * @return String this.mcName
			 */
			public String getMcName(){
				return this.mcName;
			}
			
			/**
			 * 设置 贷方科目名称
			 * @param String mcName 
			 */
			public void setMcName(String mcName){
				this.mcName = mcName;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 贷方金额
			 * @return String this.mcMoney
			 */
			public String getMcMoney(){
				return this.mcMoney;
			}
			
			/**
			 * 设置 贷方金额
			 * @param String mcMoney 
			 */
			public void setMcMoney(String mcMoney){
				this.mcMoney = mcMoney;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 贷方数量 若无数量,写0
			 * @return String this.mcNum
			 */
			public String getMcNum(){
				return this.mcNum;
			}
			
			/**
			 * 设置 贷方数量 若无数量,写0
			 * @param String mcNum 
			 */
			public void setMcNum(String mcNum){
				this.mcNum = mcNum;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 结算方式 结算方式有 现金，支票，现金支票，转账支票，银行汇票，商业汇票
			 * @return String this.settleType
			 */
			public String getSettleType(){
				return this.settleType;
			}
			
			/**
			 * 设置 结算方式 结算方式有 现金，支票，现金支票，转账支票，银行汇票，商业汇票
			 * @param String settleType 
			 */
			public void setSettleType(String settleType){
				this.settleType = settleType;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 支(汇)票号
			 * @return String this.chequeNo
			 */
			public String getChequeNo(){
				return this.chequeNo;
			}
			
			/**
			 * 设置 支(汇)票号
			 * @param String chequeNo 
			 */
			public void setChequeNo(String chequeNo){
				this.chequeNo = chequeNo;
			}
		   		
		
		
			
								/**
			 * 获取 票号发生日期
			 * @return Date this.chequeDate
			 */
			public Date getChequeDate(){
				return this.chequeDate;
			}
			
			/**
			 * 设置 票号发生日期
			 * @param Date chequeDate 
			 */
			public void setChequeDate(Date chequeDate){
				this.chequeDate = chequeDate;
			}
								/**
			 * 获取 发生时间
			 * @return Date this.createDate
			 */
			public Date getCreateDate(){
				return this.createDate;
			}
			
			/**
			 * 设置 发生时间
			 * @param Date createDate 
			 */
			public void setCreateDate(Date createDate){
				this.createDate = createDate;
			}
						
		  			/**
			 * 获取 发生额
			 * @return String this.money
			 */
			public String getMoney(){
				return this.money;
			}
			
			/**
			 * 设置 发生额
			 * @param String money 
			 */
			public void setMoney(String money){
				this.money = money;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 部门编码
			 * @return String this.deptNo
			 */
			public String getDeptNo(){
				return this.deptNo;
			}
			
			/**
			 * 设置 部门编码
			 * @param String deptNo 
			 */
			public void setDeptNo(String deptNo){
				this.deptNo = deptNo;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 职员编码
			 * @return String this.empNo
			 */
			public String getEmpNo(){
				return this.empNo;
			}
			
			/**
			 * 设置 职员编码
			 * @param String empNo 
			 */
			public void setEmpNo(String empNo){
				this.empNo = empNo;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 客户编码
			 * @return String this.custoNo
			 */
			public String getCustoNo(){
				return this.custoNo;
			}
			
			/**
			 * 设置 客户编码
			 * @param String custoNo 
			 */
			public void setCustoNo(String custoNo){
				this.custoNo = custoNo;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 供应商编码
			 * @return String this.applyNo
			 */
			public String getApplyNo(){
				return this.applyNo;
			}
			
			/**
			 * 设置 供应商编码
			 * @param String applyNo 
			 */
			public void setApplyNo(String applyNo){
				this.applyNo = applyNo;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 业务员编码
			 * @return String this.salesmanNo
			 */
			public String getSalesmanNo(){
				return this.salesmanNo;
			}
			
			/**
			 * 设置 业务员编码
			 * @param String salesmanNo 
			 */
			public void setSalesmanNo(String salesmanNo){
				this.salesmanNo = salesmanNo;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 备注
			 * @return String this.note
			 */
			public String getNote(){
				return this.note;
			}
			
			/**
			 * 设置 备注
			 * @param String note 
			 */
			public void setNote(String note){
				this.note = note;
			}

			public String getEnterPname() {
				return enterPname;
			}

			public void setEnterPname(String enterPname) {
				this.enterPname = enterPname;
			}

			public Integer getCheckFlag() {
				return checkFlag;
			}

			public void setCheckFlag(Integer checkFlag) {
				this.checkFlag = checkFlag;
			}
		   		
		
		
			
			}