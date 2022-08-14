
#Bloco de código para armazenar na váriavel diskconfigs

$datadiskId1 = $vm.StorageProfile.DataDisks[0].ManagedDisk.Id
$RecoveryReplicaDiskAccountType = $vm.StorageProfile.DataDisks[0].ManagedDisk.StorageAccountType
$RecoveryTargetDiskAccountType = $vm.StorageProfile.DataDisks[0].ManagedDisk.StorageAccountType

$DataDisk1ReplicationConfig  = New-AzRecoveryServicesAsrAzureToAzureDiskReplicationConfig -ManagedDisk -LogStorageAccountId $EastUSCacheStorageAccount.Id `
         -DiskId $datadiskId1 -RecoveryResourceGroupId $RecoveryRG.ResourceId -RecoveryReplicaDiskAccountType $RecoveryReplicaDiskAccountType `
         -RecoveryTargetDiskAccountType $RecoveryTargetDiskAccountType


$diskconfigs = $DataDisk1ReplicationConfig 

#Comando para pegar o item que está sendo protegido no protection container

$protItem = Get-AzRecoveryServicesAsrReplicationProtectedItem -FriendlyName "testVM" -ProtectionContainer $PrimaryProtContainer

#Comando para adicionar um novo disco à vm (comando que está dando problema)

Add-AzRecoveryServicesAsrReplicationProtectedItemDisk -ReplicationProtectedItem $protItem -AzureToAzureDiskReplicationConfiguration $diskconfigs


