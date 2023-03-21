<template>
	<view class="uni-pa-3">
		<!-- 页面内容 >>>>>>>>>>>>> -->
		<view v-if="!isCreateFormShown && !isUpdateFormShown">
			<!-- 新增按钮 -->
			<u-sticky>
				<view class="uni-mb-3">
					<u-button text="新增" type="success" size="small" @click="doUiAction('startCreateItem')"></u-button>
				</view>
			</u-sticky>
			<!-- 表格列表 -->
			<uni-table :loading="isTableLoading" border>
				<uni-tr>
					<uni-th width="150">操作</uni-th>
					<uni-th>ID</uni-th>
					<uni-th>学生ID</uni-th>
					<uni-th>学生名字</uni-th>
					<uni-th>性别</uni-th>
					<uni-th>出生日期</uni-th>
					<uni-th>年级</uni-th>
					<uni-th>身高</uni-th>
					<uni-th>学生状态</uni-th>
					<uni-th>备注</uni-th>
					<uni-th>操作者</uni-th>
					<uni-th>操作时间</uni-th>
				</uni-tr>
				<uni-tr v-for="(item, index) in tableData" :key="index">
					<uni-td>
						<u--text type="success" text="班级列表" @click="doUiAction('redirect', item)"></u--text>
						<u--text type="success" text="修改" @click="doUiAction('startUpdateItem', item)"></u--text>
						<u--text type="success" text="删除" @click="doUiAction('deleteItem', item)"></u--text>
					</uni-td>
					<uni-td>{{ item.id }}</uni-td>
					<uni-td>{{ item.studentId }}</uni-td>
					<uni-td>{{ item.name }}</uni-td>
					<uni-td>{{ item.gender }}</uni-td>
					<uni-td>{{ item.dateOfBirth }}</uni-td>
					<uni-td>{{ item.level }}</uni-td>
					<uni-td>{{ item.bodyHeight }}</uni-td>
					<uni-td>{{ item.studentStatus }}</uni-td>
					<uni-td>{{ item.remark }}</uni-td>
					<uni-td>{{ item.operationByUser }}</uni-td>
					<uni-td>{{ item.operationAt }}</uni-td>
				</uni-tr>
			</uni-table>
		</view>
		<!-- <<<<<<<<<<<<< 页面内容 -->

		<!-- 新增 >>>>>>>>>>>>> -->
		<uni-section title="添加信息" titleColor="#8f939c" v-if="isCreateFormShown">
			<view class="uni-pa-5">
				<!-- 表单 -->
				<uni-forms ref="createForm" :rules="rules" :modelValue="createItem">
					<uni-forms-item label="学生ID" required name="studentId">
						<uni-easyinput v-model="createItem.studentId" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="学生名字" name="name">
						<uni-easyinput v-model="createItem.name" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="性别" name="gender">
						<uni-easyinput v-model="createItem.gender" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="出生日期" name="dateOfBirth">
						<uni-easyinput v-model="createItem.dateOfBirth" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="年级" name="level">
						<uni-easyinput v-model="createItem.level" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="身高" name="bodyHeight">
						<uni-easyinput v-model="createItem.bodyHeight" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="学生状态" name="studentStatus">
						<uni-easyinput v-model="createItem.studentStatus" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="备注" name="remark">
						<uni-easyinput v-model="createItem.remark" :clearable="false"/>
					</uni-forms-item>
				</uni-forms>
				<!-- 操作按钮 -->
				<view class="uni-pb-10">
					<view>
						<u-button @click="doUiAction('createItem')" type="success" size="small">保存</u-button>
					</view>
					<view class="uni-mt-3">
						<u-button @click="isCreateFormShown = false" size="small">取消</u-button>
					</view>
				</view>
			</view>
		</uni-section>
		<!-- <<<<<<<<<<<<< 新增 -->

		<!-- 编辑 >>>>>>>>>>>>> -->
		<uni-section title="修改信息" titleColor="#8f939c" v-if="isUpdateFormShown">
			<view class="uni-pa-5">
				<!-- 表单 -->
				<uni-forms ref="updateForm" :rules="rules" :modelValue="updateItem">
					<uni-forms-item label="学生ID" required name="studentId">
						<uni-easyinput v-model="updateItem.studentId" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="学生名字" name="name">
						<uni-easyinput v-model="updateItem.name" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="性别" name="gender">
						<uni-easyinput v-model="updateItem.gender" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="出生日期" name="dateOfBirth">
						<uni-easyinput v-model="updateItem.dateOfBirth" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="年级" name="level">
						<uni-easyinput v-model="updateItem.level" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="身高" name="bodyHeight">
						<uni-easyinput v-model="updateItem.bodyHeight" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="学生状态" name="studentStatus">
						<uni-easyinput v-model="updateItem.studentStatus" :clearable="false"/>
					</uni-forms-item>
					<uni-forms-item label="备注" name="remark">
						<uni-easyinput v-model="updateItem.remark" :clearable="false"/>
					</uni-forms-item>
				</uni-forms>
				<!-- 操作按钮 -->
				<view class="uni-pb-10">
					<view>
						<u-button @click="doUiAction('updateItem')" type="success" size="small">保存</u-button>
					</view>
					<view class="uni-mt-3">
						<u-button @click="isUpdateFormShown = false" size="small">取消</u-button>
					</view>
				</view>
			</view>
		</uni-section>
		<!-- <<<<<<<<<<<<< 编辑 -->
				
  </view>
</template>

<script>
	const App = getApp();
	export default {
		data() {
			return {
				// 校验规则
				rules: {
					studentId: {
						rules: [{
							required: true,
							errorMessage: '学生ID'
						}]
					}
				},

				// 表格相关数据
				isTableLoading: true,
				tableData: [],

				// 操作相关
				isCreateFormShown: false,
				createItem: {},
				createActionData: {},
				isUpdateFormShown: false,
				updateItem: {},
				updateItemId: null,
				updateActionData: {},
				deleteItem: {},
				deleteItemId: null,
				deleteItemStudentId: null,
			};
		},
		components: {},
		props: {},
		onLoad: function(options) {
			this.doUiAction('getTableData');
		},
		onShow() {},
		methods: {
			 async doUiAction(uiActionId, uiActionData) {
        switch (uiActionId) {
          case 'getTableData':
            await this.getTableData();
            break;
          case 'startCreateItem':
            await this.prepareCreateFormData();
            await this.openCreateDrawer();
            break;
          case 'createItem':
            await this.prepareCreateValidate();
            await this.confirmCreateItemDialog();
            await this.prepareDoCreateItem();
            await this.doCreateItem();
            await this.closeCreateDrawer();
            await this.getTableData();
            break;
          case 'startUpdateItem':
            await this.prepareUpdateFormData(uiActionData);
            await this.openUpdateDrawer();
            break;
          case 'updateItem':
            await this.prepareUpdateValidate();
            await this.confirmUpdateItemDialog();
            await this.prepareDoUpdateItem();
            await this.doUpdateItem();
            await this.closeUpdateDrawer();
            await this.getTableData();
            break;
          case 'deleteItem':
            await this.prepareDeleteFormData(uiActionData);
            await this.confirmDeleteItemDialog();
            await this.prepareDoDeleteItem();
            await this.doDeleteItem();
            await this.doDeleteClassOfStudent();
            await this.clearDeleteItem();
            await this.getTableData();
            break;
          case 'redirect':
            await this.redirectToClassListForStudent(uiActionData);
            break;
          default:
            console.error("[doUiAction] uiActionId not find", { uiActionId });
            break;
        }
      },

      // ---------- 获取数据 uiAction >>>>>>>>>> --------
      async getTableData() {
        this.isTableLoading = true;
        const result = await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentList',
              actionId: 'selectItemList',
              actionData: {},
              where: {},
              orderBy: [{ column: 'operationAt', order: 'desc' }]
            }
          }
        });

        this.tableData = result.data.appData.resultData.rows;
        this.isTableLoading = false;
      },
      // ---------- <<<<<<<<<<< 获取数据 uiAction  --------

			// ---------- 新增数据 uiAction >>>>>>>>>> --------
      async prepareCreateFormData() {
        this.createItem = {};
      },
      async openCreateDrawer() {
        this.isCreateFormShown = true;
      },
      async prepareCreateValidate() {
			  if (await this.$refs.createForm.validate()) {
          return true;
        }
        throw new Error("请完善表单信息")
      },
      async confirmCreateItemDialog() {
				return new Promise( async resolve=> {
					uni.showModal({
						title: "新增", 
						content: "确定新增吗？", 
						success: (res) => {
							if(res.confirm){
								resolve(res.confirm)
							}else{
								throw new Error("[confirmCreateFormDialog] 否");
							}
						}
					})
				})
			},
      prepareDoCreateItem() {
        const { id, ...data } = this.createItem;
        this.createActionData = data;
      },
      async doCreateItem() {
        await App.loading("新增学生");
        await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentList',
              actionId: 'insertItem',
              actionData: this.createActionData
            }
          }
        })
        await App.success("新增学生成功");
      },
      async closeCreateDrawer() {
        this.isCreateFormShown = false;
        this.createItem = {};
        this.createActionData = null;
      },
      // ---------- <<<<<<<<<<< 新增数据 uiAction  --------

			// ---------- 修改数据 uiAction >>>>>>>>>>>> --------
      async prepareUpdateFormData(funObj) {
        this.updateItem = _.cloneDeep(funObj);
      },
      async openUpdateDrawer() {
        this.isUpdateFormShown = true;
      },
      async prepareUpdateValidate() {
        if (await this.$refs.updateForm.validate()) {
          return true;
        }
        throw new Error("请完善表单信息")
      },
      async confirmUpdateItemDialog() {
				return new Promise( async resolve=> {
					uni.showModal({
						title: "修改", 
						content: "确定修改吗？", 
						success: (res) => {
							if(res.confirm){
								resolve(res.confirm)
							}else{
								throw new Error("[confirmUpdateItemDialog] 否");
							}
						}
					})
				})
      },
      async prepareDoUpdateItem() {
        const { id, ...data } = this.updateItem;
        this.updateItemId = id;
        this.updateActionData = data;
      },
      async doUpdateItem() {
        await App.loading("修改学生");
        await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentList',
              actionId: 'updateItem',
              actionData: this.updateActionData,
              where: { id: this.updateItemId }
            }
          }
        })
        await App.success("修改学生成功");
      },
      async closeUpdateDrawer() {
        this.isUpdateFormShown = false;
        this.updateItem = {};
        this.updateActionData = null;
        this.updateItemId = null;
      },
      // ---------- <<<<<<<<<<< 修改数据 uiAction  --------

			// ---------- 删除数据 uiAction >>>>>>>>>>>> --------
      async prepareDeleteFormData(funObj) {
        this.deleteItem = _.cloneDeep(funObj);
      },
      async confirmDeleteItemDialog() {
				return new Promise( async resolve=> {
					uni.showModal({
						title: "删除", 
						content: "确定删除吗？", 
						success: (res) => {
							if(res.confirm){
								resolve(res.confirm)
							}else{
								throw new Error("[confirmDeleteItemDialog] 否");
							}
						}
					})
				})
      },
      async prepareDoDeleteItem() {
        const { id, studentId } = this.deleteItem;
        this.deleteItemId = id;
        this.deleteItemStudentId = studentId;
      },
      async doDeleteItem() {
				await App.loading('删除学生')
        await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentList',
              actionId: 'deleteItem',
              actionData: {},
              where: { id: this.deleteItemId }
            }
          }
        });
        await App.success("删除学生成功");
      },
      async doDeleteClassOfStudent() {
        await App.loading("删除学生的班级");
        await App.jianghuAxios({
          data: {
            appData: {
              pageId: 'studentList',
              actionId: 'deleteClassOfStudent',
              actionData: {},
              where: { studentId: this.deleteItemStudentId }
            }
          }
        });
        await App.success("删除成功");
      },
      async clearDeleteItem() {
        this.deleteItem = {};
        this.deleteItemId = null;
        this.deleteItemStudentId = null;
      },
      // ---------- <<<<<<<<<<< 删除数据 uiAction  --------

			// ---------- 学生的班级列表 uiAction >>>>>>>>>>>> --------
      async redirectToClassListForStudent(funObj) {
				App.goTo(`classOfStudent/index?studentId=${funObj.studentId}&title=${funObj.name}`);
      },
      // ---------- <<<<<<<<<<< 学生的班级列表 uiAction  --------
		}
	};
</script>
<style>

</style>
