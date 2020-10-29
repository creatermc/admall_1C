
&AtClient
Procedure SaveSettingToFile(Command)
	Var ClosingOptions;
	ClosingOptions = New Structure();
	ClosingOptions.Insert("SaveCentralServerList", SaveCentralServerList);
	ClosingOptions.Insert("SaveClusterInfobaseAdministratorPasswords", SaveClusterInfobaseAdministratorPasswords);
	ClosingOptions.Insert("SaveServerAdministratorPasswords", SaveServerAdministratorPasswords);
	ClosingOptions.Insert("FileSettingsPath", FileSettingPath);
	Close(ClosingOptions);
EndProcedure

&AtClient
Procedure CloseSaveSettingsForm(Command)
	Close();
EndProcedure

&AtClient
Procedure FileSelectionNotify(SelectedFiles, UploadOptions) Export
	If Not ValueIsFilled(SelectedFiles) Then
		Return;
	EndIf;
	FileSettingPath = SelectedFiles[0];
EndProcedure

&AtClient
Procedure ItemFileSettingPathStartChoice(Item, SelectionData, StandardProcessing)
	Var FileOpenType, NotifyDescription;
	StandardProcessing = False;
	FileOpenType = FileDialogMode.Save;
	FileOpenDialog = New FileDialog(FileOpenType);
	FileOpenDialog.Directory = FileSettingPath;
	If IsBlankString(FileSettingPath) Then
		FileOpenDialog.FullFileName = "srvadmsettings";
	Else
		FileOpenDialog.FullFileName = FileSettingPath;
	EndIf;
	Filter = NStr("ru = 'Текст';SYS=''", "ru") + "(*.xml)|*.xml";
	FileOpenDialog.Filter = Filter;
	FileOpenDialog.Multiselect = False;
	FileOpenDialog.Title = Nstr("'Выберете файл для сохранения настроек';SYS=''", "ru");
	NotifyDescription = New NotifyDescription("FileSelectionNotify", ThisForm);
	FileOpenDialog.Show(NotifyDescription);
EndProcedure

&AtClient
Procedure OnOpen(Cancel)
	
EndProcedure
