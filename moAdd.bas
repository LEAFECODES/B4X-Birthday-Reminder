B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private imgThumbnail As B4XImageView
	Private lblAdd As B4XView
	Private lblBack As B4XView
	Private txtBirthday As B4XFloatTextField
	Private txtFirstname As B4XFloatTextField
	Private txtLastName As B4XFloatTextField
	Private txtPhone As B4XFloatTextField
	Private lblSave As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lyAddBirthday")
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub B4XPage_Appear
	Dim today As String = DateTime.Date(DateTime.Now)
	
	txtBirthday.Text = today
End Sub


Private Sub lblSave_Click
	'Verify if the user enters all informations
	If txtFirstname.Text = "" Or txtFirstname.text.trim = "" Then
		xui.MsgboxAsync("Please enter first name before you proceed","First Name Missing")
		Return
	End If
	
	If txtLastName.Text = "" Or txtLastName.text.trim = "" Then
		xui.MsgboxAsync("Please enter last name before you proceed","Last Name Missing")
		Return
	End If
	
	If txtBirthday.Text = "" Or txtBirthday.text.trim = "" Then
		xui.MsgboxAsync("Please chooose birthdate before you proceed","Birthday Missing")
		Return
	End If
	
	If txtPhone.Text = "" Or txtPhone.text.trim = "" Then
		xui.MsgboxAsync("Please enter Phone number before you proceed","Phone Number Missing")
		Return
	End If
	
	
	'Insert into the database	
	B4XPages.MainPage.sql.ExecNonQuery2("INSERT INTO tblBirthdays VALUES(?,?,?,?,?,?)", Array As Object(Null,txtFirstname.Text,txtLastName.Text,txtBirthday.Text,txtPhone.Text,Null))
	
	xui.MsgboxAsync("Thank you, your event is succesfully saved to the database","Success")
	
	txtFirstname.Text = ""
	txtLastName.Text = ""
	txtPhone.Text = ""
	txtBirthday.Text = DateTime.Date(DateTime.Now)
End Sub

Private Sub lblBack_Click
	B4XPages.ShowPageAndRemovePreviousPages("Mainpage")
End Sub

Private Sub lblChooseCalendar_Click
	Dim dd As DateDialog
	
	Dim today As Long = DateTime.Now
	Dim day As Int = DateTime.GetDayOfMonth(today)
	Dim month As Int = DateTime.GetMonth(today)
	Dim year As Int = DateTime.GetYear(today)
	
	
	dd.SetDate(day,month,year)
	

	Dim sf As Object = dd.ShowAsync("", "Choose Date", "Set", "", "Cancel", Null, False)
	Wait For (sf) Dialog_Result(Result As Int)
	If Result = DialogResponse.POSITIVE Then
		Log(DateTime.Date(dd.DateTicks))
		txtBirthday.Text = DateTime.Date(dd.DateTicks)
	End If
End Sub