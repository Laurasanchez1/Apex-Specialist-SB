trigger MaintenanceRequest on Case (before update, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    if(Trigger.isUpdate && Trigger.isAfter)
    MaintenanceRequestHelper.updateWorkOrders(Trigger.New, Trigger.OldMap);
}