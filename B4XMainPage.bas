B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

'github desktop ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	'Declare the Module
	Dim pgAdd As moAdd
	Dim pgSingle As moSingle
	
	Dim dbName As String = "Birthdays.db"
	Dim sql As SQL
	Private clvBirthdays As CustomListView
	Private lblName As B4XView
	Private lblDetails As B4XView
	Private lblRemainingdays As B4XView
	Private imgThumbnail As B4XImageView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	sql.Initialize(xui.DefaultFolder,dbName,True)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	pgAdd.Initialize
	pgSingle.Initialize
	B4XPages.AddPage("idAdd",pgAdd)
	B4XPages.AddPage("idSingle",pgSingle)
	
	'Set date format
	DateTime.DateFormat = "yyyy-MM-dd" '2024-09-07
	
	Dim userData As Map
	userData.Initialize
	userData.Put("id",DBUtils.DB_INTEGER)
	userData.Put("firstname",DBUtils.DB_TEXT)
	userData.Put("lastname",DBUtils.DB_TEXT)
	userData.Put("dob",DBUtils.DB_TEXT)
	userData.Put("phonenumber",DBUtils.DB_TEXT)
	userData.Put("image",DBUtils.DB_BLOB)
	
	If File.Exists(xui.DefaultFolder,dbName) = True Then
		DBUtils.CreateTable(sql,"tblBirthdays",userData,"id")
		Log("DB Succesful")
		'DBUtils.CreateTable(sql,"DBVersion",CreateMap("version":DBUtils.DB_INTEGER),"")
		
		Log(DBUtils.GetDBVersion(sql))
	End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub B4XPage_Appear
	'lOAD DATABASE INFORMATIONS
	
	Dim Result As ResultSet
	Result = sql.ExecQuery("SELECT * FROM tblBirthdays")
	
	clvBirthdays.Clear
	
	Do While Result.NextRow
		Log("Firstname: " & Result.GetString("firstname"))
		Dim fname As String = Result.GetString("firstname")
		Dim lname As String = Result.GetString("lastname")
		Dim dob As String = Result.GetString("dob")
		Dim phone As String = Result.GetString("phonenumber")
		Dim id As Int = Result.GetString("id")
		
		'clvBirthdays.AddTextItem($"${fname} ${lname} - ${dob}"$,id)
		clvBirthdays.Add(createBirthdaylist(fname & " " & lname,246),id)
	Loop
	
	
End Sub

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub

Private Sub lblAdd_Click
	B4XPages.ShowPage("idAdd")
End Sub




Sub createBirthdaylist(fullname As String,daysremaing As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,0,0,clvBirthdays.AsView.Width,100dip)
	p.LoadLayout("itemList")
	
	lblName.Text = fullname
	lblRemainingdays.Text = daysremaing
	
	Return p
End Sub



Private Sub clvBirthdays_ItemClick (Index As Int, Value As Object)
	
	Log(Value)
	
	pgSingle.userid = Value
	Sleep(0)
	B4XPages.ShowPage("idSingle")
	
End Sub