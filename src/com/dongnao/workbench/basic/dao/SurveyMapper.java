package com.dongnao.workbench.basic.dao;
import java.util.List;

import com.dongnao.workbench.common.bean.Survey;

public interface SurveyMapper {
	/**
	 * 新增餐饮品牌方法
	 * @param brand Brand:实体类
	 */
	public int add(Survey survey);

	public List<Survey> listByCondition(Survey survey);
}
