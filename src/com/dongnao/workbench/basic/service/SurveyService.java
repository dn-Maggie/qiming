package com.dongnao.workbench.basic.service;

import java.util.List;

import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.bean.Survey;

public interface SurveyService {
	/**
	 * 新增
	 */
	public ResultMessage add(Survey survey);

	public List<Survey> listByCondition(Survey survey);
}
