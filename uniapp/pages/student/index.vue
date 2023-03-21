<template>
	<view class="jh-p-10">
		<u-sticky>
			<view class="jh-p-b-10">
				<u-button text="新增" type="success" size="small"></u-button>
			</view>
		</u-sticky>
		
		<!-- <u-list>
			<u-list-item
				v-for="(item, index) in tableData"
				:key="index"> -->
				<view class="jh-list-item" v-for="(item, index) in tableData"
				:key="index">
					<u-row  justify="space-between" gutter="10">
						<u-col span="6">
								<view>ID: {{item.id}}</view>
						</u-col>
						<u-col span="6">
								<view>学生ID: {{item.studentId}}</view>
						</u-col>
						<u-col span="6">
								<view>学生名字: {{item.name}}</view>
						</u-col>
						<u-col span="6">
								<view>性别: {{item.gender}}</view>
						</u-col>
						<u-col span="6">
								<view>出生日期: {{item.dateOfBirth}}</view>
						</u-col>
						<u-col span="6">
								<view>年级: {{item.level}}</view>
						</u-col>
						<u-col span="6">
								<view>身高: {{item.bodyHeight}}</view>
						</u-col>
						<u-col span="6">
								<view>学生状态: {{item.studentStatus}}</view>
						</u-col>
						<u-col span="6">
								<view>备注: {{item.remark}}</view>
						</u-col>
						<u-col span="6">
								<view>操作者: {{item.operationByUser}}</view>
						</u-col>
						<u-col span="6">
								<view>操作时间: {{item.operationAt}}</view>
						</u-col>
					</u-row>
				</view>
				
			<!-- </u-list-item>
		</u-list> -->
		
  </view>
</template>

<script>
	import jianghuAxios from '@/common/jianghuJs/jianghuAxios.js';

	const App = getApp();
	export default {
		data() {
			return {
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

				console.log('tableData==============', this.tableData)
      },
      // ---------- <<<<<<<<<<< 获取数据 uiAction  --------


		}
	};
</script>
<style>
	.jh-list-item{
		color: '#606266';
		background-color: #fff;
    padding: 20rpx;
    border-radius: 8rpx;
    font-size: 24rpx;
		margin-bottom: 10rpx;
	}
</style>
