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
				<uni-th>班级ID</uni-th>
				<uni-th>班级名称</uni-th>
				<uni-th>班级状态</uni-th>
				<uni-th>备注</uni-th>
				<uni-th>操作者</uni-th>
				<uni-th>操作时间</uni-th>
			</uni-tr>
			<uni-tr v-for="(item, index) in tableData" :key="index">
				<uni-td>
					<u--text type="success" text="学生列表"></u--text>
					<u--text type="success" text="修改" ></u--text>
					<u--text type="success" text="删除"></u--text>
				</uni-td>
				<uni-td>{{ item.id }}</uni-td>
				<uni-td>{{ item.classId }}</uni-td>
				<uni-td>{{ item.className }}</uni-td>
				<uni-td>{{ item.classStatus }}</uni-td>
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
            await this.doDeleteStudentOfClass();
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
            await this.redirectToStudentListForClass(uiActionData);
            break;
          default:
            console.error("[doUiAction] uiActionId not find", { uiActionId });
            break;
        }
      },

      // ---------- 获取数据 uiAction >>>>>>>>>> --------
      async getTableData() {
        this.isTableLoading = true;
        const result = await jianghuAxios({
          data: {
            appData: {
              pageId: 'classList',
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
