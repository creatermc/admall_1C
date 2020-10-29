
&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
	Var AnyObject, InfobaseClient; 
	// Формируем список доступных сервисов
	// Новые сервисы необходимо добавлять в этот список
	AnyObject = NStr("ru = 'Любой объект требования';SYS='Any object'", "ru");
	InfobaseClient = NStr("ru = 'Клиентское соединение с информационной базой';SYS='Client connection'", "ru");
	Items.ItemRequirementObject.ChoiceList.Add("", AnyObject);
	Items.ItemRequirementObject.ChoiceList.Add("Connection", InfobaseClient);
	For each Service In Parameters.Services Do
		Items.ItemRequirementObject.ChoiceList.Add(Service.Name, Service.Description);
	EndDo;
	Items.ItemAssignmentRuleType.ChoiceList.Add(AdministrationAssignmentRuleType.Assign,
		Nstr("ru = 'Назначать';SYS='Assign'", "ru"));
	Items.ItemAssignmentRuleType.ChoiceList.Add(AdministrationAssignmentRuleType.DontAssign,
		Nstr("ru = 'Не назначать';SYS='Do not assign'", "ru"));
	Items.ItemAssignmentRuleType.ChoiceList.Add(AdministrationAssignmentRuleType.Auto,
		Nstr("ru = 'Авто';SYS='Auto'", "ru"));
	ObjectChange = Parameters.ObjectChange;
	If Parameters.ObjectChange Then
		AssignmentRuleID = Parameters.ruleID;
		RequirementObject = Parameters.ObjectType;
		AssignmentRuleType = Parameters.AssignmentRuleType;
		If Parameters.InfoBaseName <> "" Then
			InfobaseName = Parameters.InfoBaseName;
		EndIf;
		AdditionalParameterValue = Parameters.AdditionalParameter;
		Priority = Parameters.Priority;
	Else
		AssignmentRuleType = AdministrationAssignmentRuleType.Auto;
		RequirementObject = "";
	EndIf;	
	ThisStandartProcessing = FormAttributeToValue("object");
	DocumentationLink = ThisStandartProcessing.GetLinkDocumentation("assignment rule");
	If IsBlankString(DocumentationLink) Then
		Items.ItemDocumentationLink.Visible = False;
	EndIf;
EndProcedure

&AtClient
Procedure WriteAssignmentRuleAndCloseForm(Command)
	AssignmentRuleSettings = New Structure();
	AssignmentRuleSettings.Insert("ObjectType", RequirementObject);
	AssignmentRuleSettings.Insert("AssignmentRuleType", AssignmentRuleType);
	AssignmentRuleSettings.Insert("InfoBaseName", InfobaseName);
	AssignmentRuleSettings.Insert("RuleID", AssignmentRuleID);
	AssignmentRuleSettings.Insert("Priority", Priority);
	AssignmentRuleSettings.Insert("AdditionalParameter", AdditionalParameterValue);
	AssignmentRuleSettings.Insert("ObjectСhange", ObjectChange); 
	Close(AssignmentRuleSettings);
EndProcedure

&AtClient
Procedure ItemDocumentationLinkClick(Item)
	GotoURL(DocumentationLink);
EndProcedure
