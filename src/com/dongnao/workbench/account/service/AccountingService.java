package com.dongnao.workbench.account.service;

import java.util.List;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.account.model.Accounting;

/**
 * 描述：会计凭证管理模块service接口，提供controller操作所需方法
 *
 * @author maggie
 * @version 1.0 2016-08-15
 */
public interface AccountingService  {

	/**
	 * 新增会计凭证管理方法
	 * @param accounting Accounting:实体类
	 */
	public ResultMessage add(Accounting accounting);
	
	/**
	 * 删除会计凭证管理方法
	 * @param key:多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key);
	
	/**
	 * 根据主键查找会计凭证管理实体方法
	 * @param key String：实体主键
	 * @return accounting Accounting 实体对象
	 */
	public Accounting getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找会计凭证管理列表方法
	 * @param accounting Accounting 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<Accounting> listByCondition(Accounting accounting);
	
	/**
	 * 修改会计凭证管理方法
	 * @param accounting Accounting 实体对象
	 */	
	public ResultMessage update(Accounting accounting);
	
	//批量审核凭证
	public void auditByKey(Accounting accounting);
}