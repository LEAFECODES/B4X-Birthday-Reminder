B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private lblFullName As B4XView
	Private lblDateOfBirth As B4XView
	Private lblBack As B4XView
	Private lblEdit As B4XView
	Dim userid As Int 
	Private lblRemaining As B4XView
	
	Dim isEditMode As Boolean = False
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lySingle")
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub B4XPage_Appear
	Dim Result As ResultSet
	Result = B4XPages.MainPage.sql.ExecQuery2("SELECT * FROM tblBirthdays WHERE id = ?",Array As Object(userid))
	
	Do While Result.NextRow
		Log("Firstname: " & Result.GetString("firstname"))
		Dim fname As String = Result.GetString("firstname")
		Dim lname As String = Result.GetString("lastname")
		Dim dob As String = Result.GetString("dob")
		Dim phone As String = Result.GetString("phonenumber")
		Dim id As Int = Result.GetString("id")
		
		lblFullName.Text = fname & " " & lname
		lblDateOfBirth.text = dob
		
		lblRemaining.text = 250
	Loop
	
End Sub


Private Sub lblBack_Click
	B4XPages.ShowPageAndRemovePreviousPages("Mainpage")
End Sub

Private Sub lblEdit_Click
	
End Sub