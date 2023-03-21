<template>
	<view class="uni-pa-3">
		<u-sticky>
			<view class="uni-mb-3">
				<u-button text="新增" type="success" size="small"></u-button>
			</view>
		</u-sticky>

		<uni-table ref="table" :loading="isTableLoading" border stripe emptyText="暂无更多数据">
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
					<u--text type="success" text="班级列表"></u--text>
					<u--text type="success" text="修改" ></u--text>
					<u--text type="success" text="删除"></u--text>
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
</template>

<script>
	import jianghuAxios from '@/common/jianghuJs/jianghuAxios.js';

	const App = getApp();
	export default {
		data() {
			return {
				isTableLoading: true,
				tableData: [],
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
          case 'batchDelete':
            await this.confirmDeleteItemDialog();
            await this.doBatchDelete();
            await this.clearBatchDelete();
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
		return
        this.isTableLoading = true;
        const result = await jianghuAxios({
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

		}
	};
</script>
<style>

</style>
