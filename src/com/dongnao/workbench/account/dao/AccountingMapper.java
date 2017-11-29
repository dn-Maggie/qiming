package com.dongnao.workbench.account.dao;

import java.util.List;
import com.dongnao.workbench.account.model.Accounting;
/**
 * 描述：会计凭证管理模块dao接口，提供数据库操作方法
 *
 * @author maggie
 * @version 1.0 2016-08-15
 */
public interface AccountingMapper  {

	/**
	 * 新增会计凭证管理方法
	 * @param accounting Accounting:实体类
	 */
	void add(Accounting accounting);
	
	/**
	 * 删除会计凭证管理方法
	 * @param key String:多个由“，”分割开的id字符串
	 */
	void deleteByKey(String key);
	
	/**
	 * 根据主键查找会计凭证管理实体方法
	 * @param key String：实体主键（查询条件）
	 * @return Accounting: 实体
	 */
	public Accounting getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找会计凭证管理列表方法
	 * @param Accounting accounting：实体对象（查询条件）
	 * @return List<Accounting>: 实体对象的list
	 */
	public List<Accounting>  listByCondition(Accounting accounting);
	
	/**
	 * 修改会计凭证管理方法
	 * @param accounting Accounting：实体对象
	 */	
	public void update(Accounting accounting);
	
	//批量审核凭证
	void auditByKey(Accounting accounting);
}