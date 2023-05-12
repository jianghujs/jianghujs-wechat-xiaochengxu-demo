# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_cache`;
CREATE TABLE `_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL COMMENT '用户Id',
  `content` longtext COMMENT '缓存数据',
  `recordStatus` varchar(255) DEFAULT 'active',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '缓存表';




# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _constant
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_constant`;
CREATE TABLE `_constant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `constantKey` varchar(255) DEFAULT NULL,
  `constantType` varchar(255) DEFAULT NULL COMMENT '常量类型; object, array',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `constantValue` text COMMENT '常量内容; object, array',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = '常量表; 软删除未启用;';






# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_group`;
CREATE TABLE `_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` varchar(255) NOT NULL COMMENT 'groupId',
  `groupName` varchar(255) DEFAULT NULL COMMENT '群组名',
  `groupDesc` varchar(255) DEFAULT NULL COMMENT '群组描述',
  `groupAvatar` varchar(255) DEFAULT NULL COMMENT '群logo',
  `groupExtend` varchar(1024) DEFAULT '{}' COMMENT '拓展字段; { groupNotice: ''xx'' }',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `groupId_index` (`groupId`) USING BTREE
) ENGINE = InnoDB COMMENT = '群组表; 软删除未启用;';






# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_page`;
CREATE TABLE `_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) DEFAULT NULL COMMENT 'pageId',
  `pageFile` varchar(255) DEFAULT NULL COMMENT 'page文件指定; 默认使用pageId.html',
  `pageName` varchar(255) DEFAULT NULL COMMENT 'page name',
  `pageType` varchar(255) DEFAULT NULL COMMENT '页面类型; showInMenu, dynamicInMenu',
  `sort` varchar(255) DEFAULT NULL,
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  `pageHook` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 COMMENT = '页面表; 软删除未启用;';



INSERT INTO `_page` (`id`,`pageId`,`pageFile`,`pageName`,`pageType`,`sort`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,'help','helpV3','帮助','dynamicInMenu','11','insert',NULL,NULL,NULL);
INSERT INTO `_page` (`id`,`pageId`,`pageFile`,`pageName`,`pageType`,`sort`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'login','loginV3','登陆','','','insert',NULL,NULL,NULL);
INSERT INTO `_page` (`id`,`pageId`,`pageFile`,`pageName`,`pageType`,`sort`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (36,'studentManagement',NULL,'学生管理','showInMenu','5','insert',NULL,NULL,NULL);



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _record_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_record_history`;
CREATE TABLE `_record_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table` varchar(255) DEFAULT NULL COMMENT '表',
  `recordId` int(11) DEFAULT NULL COMMENT '数据在table中的主键id; recordContent.id',
  `recordContent` text NOT NULL COMMENT '数据',
  `packageContent` text NOT NULL COMMENT '当时请求的 package JSON',
  `operation` varchar(255) DEFAULT NULL COMMENT '操作; jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId; recordContent.operationByUserId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名; recordContent.operationByUser',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; recordContent.operationAt; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_record_id` (`recordId`) USING BTREE,
  KEY `index_table_action` (`table`, `operation`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 COMMENT = '数据历史表';




# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_resource`;
CREATE TABLE `_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accessControlTable` varchar(255) DEFAULT NULL COMMENT '数据规则控制表',
  `resourceHook` text COMMENT '[ "before": {"service": "xx", "serviceFunction": "xxx"}, "after": [] }',
  `pageId` varchar(255) DEFAULT NULL COMMENT 'page id; E.g: index',
  `actionId` varchar(255) DEFAULT NULL COMMENT 'action id; E.g: selectXXXByXXX',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `resourceType` varchar(255) DEFAULT NULL COMMENT 'resource 类型; E.g: auth service sql',
  `appDataSchema` text COMMENT 'appData 参数校验',
  `resourceData` text COMMENT 'resource 数据; { "service": "auth", "serviceFunction": "passwordLogin" } or  { "table": "${tableName}", "action": "select", "whereCondition": ".where(function() {this.whereNot( { recordStatus: \\"active\\" })})" }',
  `requestDemo` text COMMENT '请求Demo',
  `responseDemo` text COMMENT '响应Demo',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 362 COMMENT = '请求资源表; 软删除未启用; resourceId=`${appId}.${pageId}.${actionId}`';



INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (1,NULL,NULL,'login','passwordLogin','✅登录','service','{}','{\"service\": \"user\", \"serviceFunction\": \"passwordLogin\"}','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,NULL,NULL,'allPage','logout','✅登出','service','{}','{\"service\": \"user\", \"serviceFunction\": \"logout\"}','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,NULL,NULL,'allPage','userInfo','✅获取用户信息','service','{}','{\"service\": \"user\", \"serviceFunction\": \"userInfo\"}','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (4,NULL,NULL,'allPage','getConstantList','✅查询常量','sql','{}','{\"table\": \"_constant\", \"operation\": \"select\"}','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (5,NULL,NULL,'studentList','selectItemList','✅学生列表-查询列表','sql','{}','{ \"table\": \"student\", \"operation\": \"select\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (6,NULL,NULL,'studentList','insertItem','✅学生列表-添加成员','sql','{}','{ \"table\": \"student\", \"operation\": \"insert\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (7,NULL,NULL,'studentList','updateItem','✅学生列表-更新成员','sql','{}','{ \"table\": \"student\", \"operation\": \"jhUpdate\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (8,NULL,NULL,'studentList','deleteItem','✅学生列表-删除信息','sql','{}','{ \"table\": \"student\", \"operation\": \"jhDelete\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (9,NULL,NULL,'studentList','deleteClassOfStudent','✅学生列表-删除学生与班级的关联','sql','{}','{ \"table\": \"student_class\", \"operation\": \"jhDelete\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (10,NULL,NULL,'classList','selectItemList','✅班级列表-查询列表','sql','{}','{ \"table\": \"class\", \"operation\": \"select\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (11,NULL,NULL,'classList','insertItem','✅班级列表-添加成员','sql','{}','{ \"table\": \"class\", \"operation\": \"insert\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (12,NULL,NULL,'classList','updateItem','✅班级列表-更新成员','sql','{}','{ \"table\": \"class\", \"operation\": \"jhUpdate\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (13,NULL,NULL,'classList','deleteItem','✅班级列表-删除信息','sql','{}','{ \"table\": \"class\", \"operation\": \"jhDelete\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (14,NULL,NULL,'classList','deleteStudentOfClass','✅班级列表-删除班级与学生的关联','sql','{}','{ \"table\": \"student_class\", \"operation\": \"jhDelete\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (15,NULL,NULL,'studentListOfOneClass','selectCurrentList','✅班级的学生列表-查询当前班级下的学生列表','sql','{}','{ \"table\": \"view01_student_class\", \"operation\": \"select\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (16,NULL,NULL,'studentListOfOneClass','insertItem','✅班级的学生列表-建立关系','sql','{}','{ \"table\": \"student_class\", \"operation\": \"jhInsert\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (17,NULL,NULL,'studentListOfOneClass','deleteItem','✅班级的学生列表-删除信息','sql','{}','{ \"table\": \"student_class\", \"operation\": \"jhDelete\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (18,NULL,NULL,'studentListOfOneClass','selectAllList','✅班级的学生列表-查询所有学生','sql','{}','{ \"table\": \"student\", \"operation\": \"select\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (19,NULL,NULL,'classListOfOneStudent','selectCurrentList','✅学生的班级列表-查询当前学生下的班级列表','sql','{}','{ \"table\": \"view01_student_class\", \"operation\": \"select\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (20,NULL,NULL,'classListOfOneStudent','insertItem','✅学生的班级列表-建立关系','sql','{}','{ \"table\": \"student_class\", \"operation\": \"jhInsert\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (21,NULL,NULL,'classListOfOneStudent','deleteItem','✅学生的班级列表-删除信息','sql','{}','{ \"table\": \"student_class\", \"operation\": \"jhDelete\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (22,NULL,NULL,'classListOfOneStudent','selectAllList','✅学生的班级列表-查询所有班级','sql','{}','{ \"table\": \"class\", \"operation\": \"select\" }','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');
INSERT INTO `_resource` (`id`,`accessControlTable`,`resourceHook`,`pageId`,`actionId`,`desc`,`resourceType`,`appDataSchema`,`resourceData`,`requestDemo`,`responseDemo`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (23,NULL,NULL,'login','xcxLogin','✅小程序登录','service','{}','{\"service\": \"wechat\", \"serviceFunction\": \"login\"}','','','insert','admin','系统管理员','2022-09-15T23:46:04+08:00');



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_role`;
CREATE TABLE `_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` varchar(255) DEFAULT NULL COMMENT 'roleId',
  `roleName` varchar(255) DEFAULT NULL COMMENT 'role name',
  `roleDesc` varchar(255) DEFAULT NULL COMMENT 'role desc',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 COMMENT = '角色表; 软删除未启用;';



INSERT INTO `_role` (`id`,`roleId`,`roleName`,`roleDesc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'administrator','系统管理员','','insert',NULL,NULL,NULL);
INSERT INTO `_role` (`id`,`roleId`,`roleName`,`roleDesc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (6,'boss','掌门','','insert',NULL,NULL,NULL);
INSERT INTO `_role` (`id`,`roleId`,`roleName`,`roleDesc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (7,'disciple','门徒','','insert',NULL,NULL,NULL);



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _test_case
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_test_case`;
CREATE TABLE `_test_case` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) DEFAULT NULL COMMENT '页面Id',
  `testId` varchar(255) DEFAULT NULL COMMENT '测试用例Id; 10000 ++',
  `testName` varchar(255) DEFAULT NULL COMMENT '测试用例名',
  `uiActionIdList` varchar(255) DEFAULT NULL COMMENT 'uiAction列表; 一个测试用例对应多个uiActionId',
  `testOpeartion` text COMMENT '测试用例步骤;',
  `expectedResult` text COMMENT '期望结果',
  `operation` varchar(255) DEFAULT NULL COMMENT '操作; jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId; recordContent.operationByUserId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名; recordContent.operationByUser',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; recordContent.operationAt; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 197 COMMENT = '测试用例表';






# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _ui
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_ui`;
CREATE TABLE `_ui` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageId` varchar(255) DEFAULT NULL COMMENT 'page id; E.g: index',
  `uiActionType` varchar(255) DEFAULT NULL COMMENT 'ui 动作类型，如：fetchData, postData, changeUi',
  `uiActionId` varchar(255) DEFAULT NULL COMMENT 'action id; E.g: selectXXXByXXX',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `uiActionConfig` text COMMENT 'ui 动作数据',
  `appDataSchema` text COMMENT 'ui 校验数据',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB COMMENT = 'ui 施工方案';






# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_user`;
CREATE TABLE `_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idSequence` varchar(255) DEFAULT NULL COMMENT '自增id; 用于生成userId',
  `userId` varchar(255) DEFAULT NULL COMMENT '主键id',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名(登陆)',
  `avatar` varchar(511) DEFAULT NULL COMMENT '头像',
  `openid` varchar(255) DEFAULT NULL COMMENT '微信小程序openid',
  `sessionKey` varchar(255) DEFAULT NULL COMMENT '小程序sessionKey',
  `clearTextPassword` varchar(255) DEFAULT NULL COMMENT '明文密码',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `md5Salt` varchar(255) DEFAULT NULL COMMENT 'md5Salt',
  `userStatus` varchar(255) DEFAULT 'active' COMMENT '用户账号状态：活跃或关闭',
  `userType` varchar(255) DEFAULT NULL COMMENT '用户类型; staff, student.',
  `config` mediumtext COMMENT '配置信息',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username_index` (`username`) USING BTREE,
  UNIQUE KEY `userId_index` (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 COMMENT = '用户表';



INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (42,NULL,'admin','系统管理员',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (43,NULL,'W00001','张三丰',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (44,NULL,'W00002','张无忌',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (45,NULL,'G00001','洪七公',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (46,NULL,'G00002','郭靖',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (47,NULL,'H00001','岳不群',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (48,NULL,'H00002','令狐冲',NULL,NULL,NULL,'123456','38d61d315e62546fe7f1013e31d42f57','Xs4JSZnhiwsR','active',NULL,NULL,'insert',NULL,NULL,NULL);
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (49,NULL,'wx_S3dDftWkDjZyROUs1X7y1gL8bGl0buTH6r2g','','','oQymY5N_kyY-mp8-qYo5hnmWx2a0','0i7j3J/rhwgXFbpPdMVDZA==',NULL,NULL,NULL,'active','wxxcx_user',NULL,'jhUpdate',NULL,NULL,'2023-03-21T15:09:02+08:00');
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (60,NULL,'wx_TSvVNT7cnAenDqUXYXiCn6VAfRtHXjt-sbBh','wx_zUebTyesy_-F9GwCO4RN0SymUCCT8wulQyQV','','op3DT6DEu12uqJrTVeGUyOASsk10','mBzh0gtpQZ/6xZmJkMTaTw==',NULL,NULL,NULL,'active','wxxcx_user',NULL,'jhUpdate','wx_TSvVNT7cnAenDqUXYXiCn6VAfRtHXjt-sbBh','wx_zUebTyesy_-F9GwCO4RN0SymUCCT8wulQyQV','2023-03-22T02:28:05+08:00');
INSERT INTO `_user` (`id`,`idSequence`,`userId`,`username`,`avatar`,`openid`,`sessionKey`,`clearTextPassword`,`password`,`md5Salt`,`userStatus`,`userType`,`config`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (61,NULL,'wx_WO3BECuKoD9Za8UH32vxTycCGIBp5u1Cyhnf','wx_vZ9MldMvr8KbxbDqMZYLlUQTfKT5KIKuJOdH','','oQwye1dFIALawU6NyksniJRfccXY','0a6l8E5qwU761GdZWl9BDg==',NULL,NULL,NULL,'active','wxxcx_user',NULL,'jhUpdate','wx_WO3BECuKoD9Za8UH32vxTycCGIBp5u1Cyhnf','wx_vZ9MldMvr8KbxbDqMZYLlUQTfKT5KIKuJOdH','2023-04-28T11:23:04+08:00');



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _user_group_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_user_group_role`;
CREATE TABLE `_user_group_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL COMMENT '用户id',
  `groupId` varchar(255) NOT NULL COMMENT '群组Id',
  `roleId` varchar(255) DEFAULT NULL COMMENT '角色Id',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `groupId_index` (`groupId`) USING BTREE,
  KEY `userId_index` (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 579 COMMENT = '用户群组角色关联表; 软删除未启用;';



INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (568,'admin','adminGroup','administrator','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (569,'W00001','wudang','boss','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (570,'W00002','wudang','disciple','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (573,'G00001','gaibang','boss','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (574,'G00002','gaibang','disciple','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (577,'H00001','huashan','boss','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role` (`id`,`userId`,`groupId`,`roleId`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (578,'H00002','huashan','disciple','insert',NULL,NULL,NULL);



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _user_group_role_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_user_group_role_page`;
CREATE TABLE `_user_group_role_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL COMMENT 'userId 或者 通配符; 通配符: *',
  `group` varchar(255) DEFAULT NULL COMMENT 'groupId 或者 通配符; 通配符: *',
  `role` varchar(255) DEFAULT NULL COMMENT 'roleId 或者 通配符; 通配符: *',
  `page` varchar(255) DEFAULT NULL COMMENT 'pageId id',
  `allowOrDeny` varchar(255) DEFAULT NULL COMMENT '用户群组角色 匹配后 执行动作; allow、deny',
  `desc` varchar(255) DEFAULT NULL COMMENT '映射描述',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 COMMENT = '用户群组角色 - 页面 映射表; 软删除未启用;';



INSERT INTO `_user_group_role_page` (`id`,`user`,`group`,`role`,`page`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (1,'*','public','*','login','allow','登陆页面; 开放所有用户;','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role_page` (`id`,`user`,`group`,`role`,`page`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,'*','login','*','help,manual','allow','工具页; 开放给登陆用户;','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role_page` (`id`,`user`,`group`,`role`,`page`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'*','login','*','*','allow','所有页面; 开放给登陆用户;','insert',NULL,NULL,NULL);



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _user_group_role_resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_user_group_role_resource`;
CREATE TABLE `_user_group_role_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL COMMENT 'userId 或者 通配符; 通配符: *',
  `group` varchar(255) DEFAULT NULL COMMENT 'groupId 或者 通配符; 通配符: *',
  `role` varchar(255) DEFAULT NULL COMMENT 'roleId 或者 通配符; 通配符: *',
  `resource` varchar(255) DEFAULT NULL COMMENT 'resourceId 或者 通配符; 通配符: *, !resourceId',
  `allowOrDeny` varchar(255) DEFAULT NULL COMMENT '用户群组角色 匹配后 执行动作; allow、deny',
  `desc` varchar(255) DEFAULT NULL COMMENT '映射描述',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 COMMENT = '用户群组角色 - 请求资源 映射表; 软删除未启用;';



INSERT INTO `_user_group_role_resource` (`id`,`user`,`group`,`role`,`resource`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (1,'*','public','*','login.passwordLogin','allow','登陆resource, 开放给所有用户','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role_resource` (`id`,`user`,`group`,`role`,`resource`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,'*','login','*','allPage.*','allow','工具类resource, 开放给所有登陆成功的用户','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role_resource` (`id`,`user`,`group`,`role`,`resource`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'*','login','*','*','allow','所有resource, 开放给所有登陆成功的用户','insert',NULL,NULL,NULL);
INSERT INTO `_user_group_role_resource` (`id`,`user`,`group`,`role`,`resource`,`allowOrDeny`,`desc`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (4,'*','public','*','login.xcxLogin','allow','登陆resource, 开放给所有用户','insert',NULL,NULL,NULL);



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _user_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_user_session`;
CREATE TABLE `_user_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) DEFAULT NULL COMMENT '用户id',
  `userIp` varchar(255) DEFAULT NULL COMMENT '用户ip',
  `userIpRegion` varchar(255) DEFAULT NULL COMMENT '用户Ip区域',
  `userAgent` text COMMENT '请求的 agent',
  `deviceId` varchar(255) DEFAULT NULL COMMENT '设备id',
  `deviceType` varchar(255) DEFAULT 'web' COMMENT '设备类型; flutter, web, bot_databot, bot_chatbot, bot_xiaochengxu',
  `socketStatus` varchar(255) DEFAULT 'offline' COMMENT 'socket状态',
  `authToken` varchar(255) DEFAULT NULL COMMENT 'auth token',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userId_index` (`userId`) USING BTREE,
  KEY `userId_deviceId_index` (`userId`, `deviceId`) USING BTREE,
  KEY `authToken_index` (`authToken`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 COMMENT = '用户session表; deviceId 维度;软删除未启用;';




# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: class
# ------------------------------------------------------------

DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classId` varchar(255) DEFAULT NULL COMMENT '班级ID',
  `className` varchar(255) DEFAULT NULL COMMENT '班级名称',
  `classStatus` varchar(255) DEFAULT '正常' COMMENT '班级状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132;



INSERT INTO `class` (`id`,`classId`,`className`,`classStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (1,'C10001','武当01班','正常','重点班','jhUpdate','admin','系统管理员','2022-09-05T16:57:01+08:00');
INSERT INTO `class` (`id`,`classId`,`className`,`classStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,'C10002','丐帮01班','正常',NULL,'jhUpdate','admin','系统管理员','2022-04-27T19:52:53+08:00');
INSERT INTO `class` (`id`,`classId`,`className`,`classStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'C10003','丐帮02班','正常',NULL,'jhUpdate','admin','系统管理员','2022-04-27T19:52:53+08:00');
INSERT INTO `class` (`id`,`classId`,`className`,`classStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (4,'C10004','华山03班','正常',NULL,'jhUpdate','admin','系统管理员','2022-04-27T19:52:53+08:00');
INSERT INTO `class` (`id`,`classId`,`className`,`classStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (5,'C10005','华山01班','正常',NULL,'jhUpdate','admin','系统管理员','2022-04-27T19:52:53+08:00');



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: student
# ------------------------------------------------------------

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` varchar(255) DEFAULT NULL COMMENT '学生ID',
  `name` varchar(255) DEFAULT NULL COMMENT '学生名字',
  `gender` varchar(255) DEFAULT NULL COMMENT '性别',
  `dateOfBirth` varchar(255) DEFAULT NULL COMMENT '出生日期',
  `level` varchar(255) DEFAULT NULL COMMENT '年级',
  `bodyHeight` varchar(255) DEFAULT NULL COMMENT '身高',
  `studentStatus` varchar(255) DEFAULT NULL COMMENT '学生状态',
  `remark` mediumtext COMMENT '备注',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `studentId` (`studentId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 197;



INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (1,'S10001','马夫人','女','2022-09-15','01','168','正常',NULL,'insert','admin','系统管理员','2023-02-06T22:33:37+08:00');
INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,'S10002','丁春秋','女','2022-09-15','01','181','正常',NULL,'insert','admin','系统管理员','2022-09-15T23:46:22+08:00');
INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'S10003','王语嫣','女','2022-09-15','01','185','正常',NULL,'insert','admin','系统管理员','2022-09-15T23:47:59+08:00');
INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (4,'S10004','司马林','男','2022-09-14','01','175','正常',NULL,'insert','admin','系统管理员','2022-09-15T23:54:11+08:00');
INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (5,'S10005','邓百川','男','2022-09-15','02','180','正常',NULL,'insert','admin','系统管理员','2022-09-15T23:56:23+08:00');
INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (6,'S10006','无涯子','男','2022-09-15','02','145','正常','转学','insert','admin','系统管理员','2022-11-05T15:44:06+08:00');
INSERT INTO `student` (`id`,`studentId`,`name`,`gender`,`dateOfBirth`,`level`,`bodyHeight`,`studentStatus`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (7,'admin','管理员','男','2022-09-15','02','182','正常',NULL,'insert','admin','系统管理员','2023-02-06T20:12:26+08:00');



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: student_class
# ------------------------------------------------------------

DROP TABLE IF EXISTS `student_class`;
CREATE TABLE `student_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` varchar(255) DEFAULT NULL COMMENT '学生ID',
  `classId` varchar(255) DEFAULT NULL COMMENT '班级ID',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `operation` varchar(255) DEFAULT 'insert' COMMENT '操作; insert, update, jhInsert, jhUpdate, jhDelete jhRestore',
  `operationByUserId` varchar(255) DEFAULT NULL COMMENT '操作者userId',
  `operationByUser` varchar(255) DEFAULT NULL COMMENT '操作者用户名',
  `operationAt` varchar(255) DEFAULT NULL COMMENT '操作时间; E.g: 2021-05-28T10:24:54+08:00 ',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `studentId` (`studentId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 220;



INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (1,'S10001','C10001',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (2,'admin','C10001',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (3,'S10003','C10001',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (4,'S10001','C10002',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (5,'admin','C10002',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (6,'S10003','C10002',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (7,'S10004','C10003',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (8,'admin','C10003',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (9,'S10003','C10003',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (10,'S10004','C10004',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (11,'S10005','C10004',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (12,'S10006','C10004',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (13,'S10005','C10005',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (14,'S10006','C10005',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');
INSERT INTO `student_class` (`id`,`studentId`,`classId`,`remark`,`operation`,`operationByUserId`,`operationByUser`,`operationAt`) VALUES (15,'S10002','C10005',NULL,'insert','admin','系统管理员','2022-04-27T21:29:21+08:00');



# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _view01_user
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `_view01_user` AS
select
  `_user`.`id` AS `id`,
  `_user`.`idSequence` AS `idSequence`,
  `_user`.`userId` AS `userId`,
  `_user`.`username` AS `username`,
  `_user`.`avatar` AS `avatar`,
  `_user`.`openid` AS `openid`,
  `_user`.`sessionKey` AS `sessionKey`,
  `_user`.`clearTextPassword` AS `clearTextPassword`,
  `_user`.`password` AS `password`,
  `_user`.`md5Salt` AS `md5Salt`,
  `_user`.`userStatus` AS `userStatus`,
  `_user`.`userType` AS `userType`,
  `_user`.`config` AS `config`,
  `_user`.`operation` AS `operation`,
  `_user`.`operationByUserId` AS `operationByUserId`,
  `_user`.`operationByUser` AS `operationByUser`,
  `_user`.`operationAt` AS `operationAt`
from
  `_user`;





# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: view01_student_class
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `view01_student_class` AS
select
  distinct `student_class`.`id` AS `id`,
  `student_class`.`studentId` AS `studentId`,
  `student_class`.`classId` AS `classId`,
  `student_class`.`remark` AS `remark`,
  `student_class`.`operation` AS `operation`,
  `student_class`.`operationByUserId` AS `operationByUserId`,
  `student_class`.`operationByUser` AS `operationByUser`,
  `student_class`.`operationAt` AS `operationAt`,
  `class`.`className` AS `className`,
  `class`.`classStatus` AS `classStatus`,
  `class`.`remark` AS `classRemark`,
  `student`.`name` AS `name`,
  `student`.`gender` AS `gender`,
  `student`.`dateOfBirth` AS `dateOfBirth`,
  `student`.`level` AS `level`,
  `student`.`bodyHeight` AS `bodyHeight`,
  `student`.`studentStatus` AS `studentStatus`,
  `student`.`remark` AS `studentRemark`
from
  (
  (
    `student_class`
    left join `class` on((`student_class`.`classId` = `class`.`classId`))
  )
  left join `student` on(
    (
    `student_class`.`studentId` = `student`.`studentId`
    )
  )
  );





