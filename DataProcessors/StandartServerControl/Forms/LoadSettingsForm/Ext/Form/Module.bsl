&AtClient
Procedure ItemFileSettingsPathStartChoice(Item, ДанныеВыбора, StandardProcessing)
	Var FileDialogModeType, FileDialog, Filter, NotifyDescription;
	StandardProcessing = False;
	FileDialogModeType = FileDialogMode.Open;
	FileDialog = New FileDialog(FileDialogModeType);
	FileDialog.FullFileName = "srvadmsettings";
	FileDialog.Directory = FileSettingsPath;
	Filter = "(*.xml)|*.xml";
	FileDialog.Filter = Filter;
	FileDialog.Multiselect = False;
	FileDialog.Title = Nstr("ru = 'Выберите файл для загрузки настроек'; SYS = ''", "ru");
	NotifyDescription = New NotifyDescription("ProcessingAfterChooseFile", ThisObject);
	FileDialog.Show(NotifyDescription);
EndProcedure

&AtClient
Procedure ProcessingAfterChooseFile(SelectedFiles, UploadOptions) Export
	FileSettingsPath = SelectedFiles[0]; 	
EndProcedure

&AtClient
Procedure GetUserConfirmationToDownloadDataFromFile(UserResponse, UploadOptions) Export
	If UserResponse = DialogReturnCode.Yes Then
		CloseFormSettings = New Structure();
		CloseFormSettings.Insert("FileSettingsPath", FileSettingsPath);
		Close(CloseFormSettings);
	EndIf;
EndProcedure

&AtClient
Procedure LoadSettings(Command)
	Var QuestionText;
	QuestionText = NStr("ru = 'Загрузка настроек приведет к удалению текущих данных в дереве кластера. 
		|Вы действительно хотите выполнить загрузку данных?';SYS=''", "ru");
	ShowQueryBox(New NotifyDescription("GetUserConfirmationToDownloadDataFromFile", 
					ThisObject), QuestionText, QuestionDialogMode.YesNo);
EndProcedure

&AtClient
Procedure CanсelReadSettings(Command)
	Close();
EndProcedure
