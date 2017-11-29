package com.dongnao.workbench.account.service;
import javax.annotation.Resource;
import java.util.List;
import com.dongnao.workbench.account.dao.AccountingMapper;
import com.dongnao.workbench.account.model.Accounting;
import com.dongnao.workbench.account.service.AccountingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.util.AjaxUtils;
 
/**
 * 描述：会计凭证管理模块service接口实现类，实现service接口方法
 *
 * @author maggie
 * @version 1.0 2016-08-15
 */
@Service("accountingService")
public class AccountingServiceImpl implements AccountingService{
        @Resource
	private AccountingMapper accountingMapper;
	
 
	/**
	 * 新增会计凭证管理方法
	 * @param accounting:实体类
	 */	
	public ResultMessage add(Accounting accounting){
		accountingMapper.add(accounting);
		return AjaxUtils.getSuccessMessage();
	}
	
	/**
	 * 根据主键查找会计凭证管理实体方法
	 * @param key String 实体主键
	 * @return Accounting 实体对象
	 */
	public Accounting getByPrimaryKey(String key){
		return accountingMapper.getByPrimaryKey(key);
	}
	
	/**
	 * 删除会计凭证管理方法
	 * @param key String 多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key){
		accountingMapper.deleteByKey(key);
	}
	
	/**
	 * 根据条件查找会计凭证管理列表方法
	 * @param accounting Accounting 实体对象（查询条件）
	 * @return List<Accounting> 实体对象的list
	 */
	public List<Accounting> listByCondition(Accounting accounting){
		return accountingMapper.listByCondition(accounting);
	}
	
	/**
	 * 修改会计凭证管理方法
	 * @param accounting Accounting 实体对象
	 */	
	public ResultMessage update(Accounting accounting){
		accountingMapper.update(accounting);
		return AjaxUtils.getSuccessMessage();
	}

	/**
	 * 批量审核凭证
	 * @param expenseAccount ExpenseAccount：实体对象
	 */
	public void auditByKey(Accounting accounting) {
		accountingMapper.auditByKey(accounting);
		
	}
}