<%@ Page Language="VB" %>
<%@ import namespace="System.Data" %>
<%@ import namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs)
       
      
    End Sub
    
    Sub Page_load(ByVal sender As Object, ByVal e As System.EventArgs)
      
        Dim settingsit As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconnsit As New SqlConnection(settingsit.ConnectionString)
        Dim objcmdsit As New SqlDataAdapter("select * from seeat", objconnsit)
        Dim objcbsit As SqlCommandBuilder = New SqlCommandBuilder(objcmdsit)
        Dim dssit As New DataSet()
        objcmdsit.Fill(dssit, "seeat")
        Dim mytablesit As DataTable = dssit.Tables("seeat")
        
        
        Dim a1 As String = ""
        Dim lo As Integer = 0
        For i As Integer = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(i).Selected = False Then
                lo = 1
               
            End If
        Next
        
        For i As Integer = 0 To CheckBoxList1.Items.Count - 1
         
            If CheckBoxList1.Items(i).Selected Then
               
                lo = 0
                
                a1 = a1 & " " & CheckBoxList1.Items(i).Text
                Label1.Text = "您已選擇" & a1
            
            End If
            If lo = 1 Then
                Label1.Text = ""
            End If
     
        Next i
    
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
       
        If DropDownList2.SelectedValue <> -1 Then
            
            Label3.Text = "您已訂的場次: " & DropDownList3.SelectedItem.Text & "," & DropDownList4.SelectedValue & "學生票" & students.Text & "張" & "全票" & DropDownList2.Text & "張" & "共計" & 220 * students.Text + 280 * DropDownList2.Text & "元"
            Button3.Visible = True
            Panel4.Visible = False
            Panel1.Visible = True
            CheckBoxList1.Enabled = False
        
            Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
            Dim setting2 As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        
            Dim objconn As New SqlConnection(setting.ConnectionString)
            Dim objconn2 As New SqlConnection(setting2.ConnectionString)
        
            Dim objcmd As New SqlDataAdapter("select * from seeat", objconn)
            Dim objcmd2 As New SqlDataAdapter("select * from information", objconn2)
        
            Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
            Dim objcb2 As SqlCommandBuilder = New SqlCommandBuilder(objcmd2)
        
            Dim ds As New DataSet()
            Dim ds2 As New DataSet()
        
            objcmd.Fill(ds, "seeat")
            objcmd2.Fill(ds2, "information")
        
            Dim mytable As DataTable = ds.Tables("seeat")
            Dim mytable2 As DataTable = ds2.Tables("information")
            
            dim lockj(500)as integer
         
             
            Dim temp As String = sitarea.Text
      
       dim a1 as String=""
       dim lockstart as Integer=0   
          for j as Integer=0 to checkboxlist1.Items.Count-1
     if checkboxlist1.Items(j).Selected=True
lockj(lockstart)=checkboxlist1.Items(j).value

  CheckBoxList1.Items(j).Text = "您的訂位"
                  
                    CheckBoxList1.Items(j).Enabled = False
                            a1 = a1 & CheckBoxList1.Items(j).Value
                            
lockstart=lockstart+1
 end if     
          
          next j
          
           dim start as Integer=0 
               For i As Integer = 0 To mytable.Rows.Count - 1
            
            If mytable.Rows(i).Item("座位區") = temp Then
           
                If mytable.Rows(i).Item(1) = DropDownList3.SelectedValue Then
               
                    If mytable.Rows(i).Item(2) = DropDownList4.SelectedValue Then
                                      
       if mytable.Rows(i).item("seat")= lockj(start)
       
                    mytable.rows(i).item("confirm")="y"
              mytable.Rows(i).item("Id")=sid.text
            
             objcmd.Update(mytable.Select(Nothing, Nothing, DataViewRowState.ModifiedCurrent))
             
         start=start+1
          
        end if
        
          
                    End If
                     
                End If
            End If
        
          
          Next i
       
       
        
            Dim myrow As DataRow = mytable2.NewRow()
            
            myrow("name") = sname.Text
            myrow("Id") = sid.Text
            myrow("cell") = scell.Text
            myrow("normal") = DropDownList2.SelectedValue
            myrow("studnt") = students.Text
       
            mytable2.Rows.Add(myrow)
            Button11.Visible = False
          
            
            objcmd2.Update(mytable2.Select(Nothing, Nothing, DataViewRowState.Added))
         
            Label1.Visible = False
            counttt.Visible = False
            Button13.Visible = False
        Else
            Response.Write("請選取票種數目")
            
            
        End If
        Image1.ImageUrl ="picture/6.jpg"
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If namee.Text <> "" And IDD.Text <> "" And celll.Text <> "" Then
            sid.Text = IDD.Text
            sname.Text = namee.Text
            scell.Text = celll.Text
            first1.Visible = False
   
            Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("MOVIEConnectionString")
            Dim objconn As New SqlConnection(setting.ConnectionString)
            Dim objcmd As New SqlDataAdapter("select * from time", objconn)
            Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
            Dim ds As New DataSet()
            objcmd.Fill(ds, "time")
            Dim mytable As DataTable = ds.Tables("time")
      
            For i As Integer = 0 To mytable.Rows.Count - 1
        
                DropDownList3.Items.Add(New ListItem(mytable.Rows(i)(1), mytable.Rows(i)(0)))
        
       
            Next
            Panel6.Visible = True
            Image1.ImageUrl = "picture/2.jpg"
            '  Dim k As String
            '  k = Image1.ImageUrl.ToString()
            '  k = k + ";"
        Else
            Response.Write("系統訊息:資料沒輸完全喔")
        End If
 
               
        
        
        
    End Sub

    
    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
       
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconn As New SqlConnection(setting.ConnectionString)
        Dim objcmd As New SqlDataAdapter("select * from seeat", objconn)
        Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
        Dim ds As New DataSet()
        objcmd.Fill(ds, "seeat")
        Dim mytable As DataTable = ds.Tables("seeat")
        
        Dim lo As Integer = 1
        Dim a1 As String = ""
        
        
        
        
        For i As Integer = 0 To CheckBoxList1.Items.Count - 1
            
          
       
        Next i
    End Sub

    Protected Sub Button3_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        
        Panel1.Visible = False
        
        Label1.Text = ""
        Label2.Text = ""
        
        Response.Redirect("default.aspx")
    End Sub
 

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs)
       
   
       
        
        Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconn As New SqlConnection(setting.ConnectionString)
        Dim objcmd As New SqlDataAdapter("select * from seeat", objconn)
        Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
        Dim ds As New DataSet()
        objcmd.Fill(ds, "seeat")
        Dim mytable2 As DataTable = ds.Tables("seeat")
   
    End Sub

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
       
       
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub Button5_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
       
     
     
        Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconn As New SqlConnection(setting.ConnectionString)
        Dim objcmd As New SqlDataAdapter("select * from seeat", objconn)
        Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
        Dim ds As New DataSet()
        objcmd.Fill(ds, "seeat")
        Dim mytable2 As DataTable = ds.Tables("seeat")
        
        Dim lo As Integer = 1
        Dim a1 As String = ""
       
        
        
      
        
       
        
    End Sub

   
    Protected Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs)
     
    
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs)
      
   
    End Sub

    
    
    Protected Sub Button11_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If CheckBoxList1.SelectedValue <> "" Then
            Panel1.Visible = False
        
            Dim lock As Integer
      
            Panel4.Visible = True
            For j As Integer = 0 To CheckBoxList1.Items.Count - 1
                If CheckBoxList1.Items(j).Selected Then
                    lock = lock + 1
                End If
            Next
        
        
            For i As Integer = 0 To lock
                DropDownList2.Items.Add(New ListItem(i, i))
        
            Next i
            Image1.ImageUrl = "picture/5.jpg"
        Else
            Response.Write("座位沒選喔!!!")
        End If
        
    End Sub

    Protected Sub Button9_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button10_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lock As Integer = 0
        For j As Integer = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(j).Selected Then
                lock = lock + 1
            End If
        Next
       
        If DropDownList2.SelectedItem.Value <> -1 Then
            
       
                
            students.Text = lock - DropDownList2.SelectedItem.Value
        Else
           
            students.Text = "請選擇全票數量"
           
        End If
        Label4.Text = "目前共計" & 280 * DropDownList2.Text + 220 * students.Text & "元"
        
    End Sub
    
    Protected Sub Button9_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        If IDD.Text <> "" Then
            sid.Text = IDD.Text
            sname.Text = namee.Text
            scell.Text = celll.Text
            first1.Visible = False
           
        Else
            Response.Write("資料沒輸全喔")
        End If
    End Sub

    Protected Sub TextBox2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        
    End Sub

    Protected Sub Button10_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        CheckBoxList1.RepeatDirection = RepeatDirection.Horizontal
        CheckBoxList1.RepeatColumns = 6
                     
        
        
        
        Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconn As New SqlConnection(setting.ConnectionString)
        Dim objcmd As New SqlDataAdapter("select * from seeat", objconn)
        Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
        Dim ds As New DataSet()
        objcmd.Fill(ds, "seeat")
        Dim mytable2 As DataTable = ds.Tables("seeat")
     
        
        
        
        
        
        For i As Integer = 0 To mytable2.Rows.Count - 1
         
            CheckBoxList1.Items.Add(New ListItem(mytable2.Rows(i).Item("seat"), mytable2.Rows(i).Item("seat")))
        
        Next i
    End Sub

    Protected Sub DropDownList3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
       
        Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("MOVIEConnectionString")
        Dim objconn As New SqlConnection(setting.ConnectionString)
        Dim objcmd As New SqlDataAdapter("select * from time", objconn)
        Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
        Dim ds As New DataSet()
        objcmd.Fill(ds, "time")
        Dim mytable2 As DataTable = ds.Tables("time")
        
        '清除殘留資料
        For j As Integer = 0 To mytable2.Columns.Count - 3
        
            DropDownList4.Items.Clear()
            
        Next j
        '從電影對應到場次產生至dropdownlistbox
        If DropDownList3.SelectedValue <> "請選擇" Then
            For i As Integer = 0 To mytable2.Columns.Count - 3
               
                'If mytable2.Rows(DropDownList3.SelectedIndex - 1).Item(i + 2) <> "none" Then
                DropDownList4.Items.Add(New ListItem(mytable2.Rows(DropDownList3.SelectedIndex - 1).Item(i + 2), mytable2.Rows(DropDownList3.SelectedIndex - 1).Item(i + 2)))
               
                DropDownList4.Enabled = True
                Button12.Enabled = True
                ' End If
            Next i
        Else
            DropDownList4.Enabled = False
        End If
    End Sub

    Protected Sub ImageMap1_Click(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ImageMapEventArgs)
        Image1.ImageUrl = "picture/4.jpg"
        sitarea.Text = e.PostBackValue
        
        CheckBoxList1.RepeatDirection = RepeatDirection.Horizontal

                     
        Dim setting As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconn As New SqlConnection(setting.ConnectionString)
        Dim objcmd As New SqlDataAdapter("select * from seeat", objconn)
        Dim objcb As SqlCommandBuilder = New SqlCommandBuilder(objcmd)
        
        Dim ds As New DataSet()
        objcmd.Fill(ds, "seeat")
        Dim mytable2 As DataTable = ds.Tables("seeat")
                  
        Dim temp As String
        temp = e.PostBackValue
        Dim cc As Integer = 0
      
        
        For i As Integer = 0 To mytable2.Rows.Count - 1
            
            If mytable2.Rows(i).Item("座位區") = temp Then
             
                If mytable2.Rows(i).Item(1) = DropDownList3.SelectedValue Then
               
                    If mytable2.Rows(i).Item(2) = DropDownList4.SelectedValue Then
                            
                        If temp = "d" Or temp = "e" Then
                            CheckBoxList1.RepeatColumns = 2
                        Else
                            CheckBoxList1.RepeatColumns = 8
                            
                        End If
                        CheckBoxList1.Items.Add(New ListItem(mytable2.Rows(i).Item("seat"), mytable2.Rows(i).Item("seat")))
                   
                        If temp = "a" Then
                            Image2.ImageUrl = "picture/a.JPG"
                        ElseIf temp = "b" Then
                            Image2.ImageUrl = "picture/b.JPG"
                        ElseIf temp = "c" Then
                            Image2.ImageUrl = "picture/c.JPG"
                        ElseIf temp = "d" Then
                            Image2.ImageUrl = "picture/d.JPG"
                        ElseIf temp = "e" Then
                            Image2.ImageUrl = "picture/e.JPG"
                        End If
                        
                        
                        
                            
                        If mytable2.Rows(i)("confirm") = "y" Then
                            CheckBoxList1.Items(cc).Text = "已訂位"
                            CheckBoxList1.Items(cc).Enabled = False
                            CheckBoxList1.Items(cc).Selected = False
                        End If
                        cc = cc + 1
               
         
                    End If
                     
                End If
            End If
        
          
        Next i
        
        Dim cc2 As Integer = 0
        Dim cc3 As Integer = 0
        
        For x As Integer = 0 To CheckBoxList1.Items.Count - 1
            
            If CheckBoxList1.Items(x).Enabled = False Then
                cc2 = cc2 + 1
            End If
            cc3 = cc3 + 1
        Next x
        counttt.Text = "此區剩下" & cc3 - cc2 & "個座位"
        
 
        Panel1.Visible = True
        Panel5.Visible = False
    End Sub

    Protected Sub Button12_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Panel6.Visible = False
        Panel5.Visible = True
        Image1.ImageUrl = "picture/3.jpg"
    End Sub

    Protected Sub Button13_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Panel1.Visible = False
        CheckBoxList1.Items.Clear()
        Panel5.Visible = True
    End Sub

    Protected Sub Button3_Click2(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("ticketsit.aspx")
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body style="background-color: #ffcc33">
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label13" runat="server" Text="影城訂票系統"></asp:Label>
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click2" Text="離開" Visible="False" />
        <asp:Label ID="Label3" runat="server" Width="695px"></asp:Label>
        &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    </div>
        <asp:Panel ID="first1" runat="server" Height="4px" Width="297px">
            <br />
            <asp:Label ID="名" runat="server" Text="姓名"></asp:Label>
            <asp:TextBox ID="namee" runat="server"></asp:TextBox><br />
            <br />
            <asp:Label ID="IDDD" runat="server" Text="身份證字號"></asp:Label>
            <asp:TextBox ID="IDD" runat="server"></asp:TextBox><br />
            <br />
            <asp:Label ID="Label7" runat="server" Text="手機號碼"></asp:Label>
            <asp:TextBox ID="celll" runat="server"></asp:TextBox><br />
            <br />
            <br />
            &nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="確定" Width="78px" /></asp:Panel>
        <asp:Panel ID="Panel4" runat="server" Height="134px" Width="228px" Visible="False" BackColor="Red">
            <asp:Label ID="Label10" runat="server" Text="請選擇票種數" Width="96px"></asp:Label><br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="全票數"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Value="-1">請選擇全票數</asp:ListItem>
            </asp:DropDownList><br />
            <asp:Label ID="Label12" runat="server" Text="學生票數"></asp:Label>
            <asp:Label ID="students" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="送出" />
            <asp:Label ID="Label4" runat="server" Width="173px"></asp:Label></asp:Panel>
        <asp:Panel ID="Panel6" runat="server" Height="50px" Width="495px" Visible="False" BackColor="Red">
            <br />
            <asp:Label ID="Label8" runat="server" Text="電影名稱"></asp:Label>
            <asp:DropDownList ID="DropDownList3" runat="server" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem>請選擇</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="Label9" runat="server" Text="時段"></asp:Label>
            <asp:DropDownList ID="DropDownList4" runat="server" Enabled="False" AutoPostBack="True">
            </asp:DropDownList><br />
            <br />
            <asp:Button ID="Button12" runat="server" Text="確定" Enabled="False" OnClick="Button12_Click" /><br />
        </asp:Panel>
        <asp:Panel ID="Panel5" runat="server" Height="50px" Width="125px" Visible="False">
            <asp:Label ID="Label6" runat="server" Text="請選擇一個座位區塊" Width="270px"></asp:Label><br />
            <asp:ImageMap ID="ImageMap1" runat="server" Height="254px" HotSpotMode="PostBack"
                ImageAlign="Middle" ImageUrl="None.JPG" OnClick="ImageMap1_Click" Style="position: relative"
                Width="407px">
                <asp:RectangleHotSpot Bottom="200" HotSpotMode="PostBack" Left="5" PostBackValue="d"
                    Right="55" Top="80" />
                <asp:RectangleHotSpot Bottom="200" HotSpotMode="PostBack" Left="350" PostBackValue="e"
                    Right="400" Top="80" />
                <asp:RectangleHotSpot Bottom="65" HotSpotMode="PostBack" Left="65" PostBackValue="a"
                    Right="340" Top="45" />
                <asp:RectangleHotSpot Bottom="150" HotSpotMode="PostBack" Left="65" PostBackValue="b"
                    Right="340" Top="77" />
                <asp:RectangleHotSpot Bottom="235" HotSpotMode="PostBack" Left="65" PostBackValue="c"
                    Right="340" Top="160" />
            </asp:ImageMap><br />
            &nbsp;&nbsp;
        </asp:Panel>
        <asp:Panel ID="Panel1" runat="server" Height="1px" Width="686px" Visible="False">
        <asp:Label ID="Label2" runat="server">訂位區</asp:Label>
            &nbsp;
            <asp:Label ID="Label14" runat="server" Text="座位區"></asp:Label>
            <asp:Label ID="sitarea" runat="server"></asp:Label>&nbsp;<br />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; 
            <br />
        <asp:CheckBoxList ID="CheckBoxList1" runat="server" AutoPostBack="True" RepeatColumns="1" Height="150px" Width="395px">
        </asp:CheckBoxList>
            <asp:Image ID="Image2" runat="server" Height="188px" Style="left: 414px; position: relative;
                top: -167px" Width="275px" />
            &nbsp; &nbsp;
            <asp:Label ID="Label1" runat="server" Text="請點選座位" Width="465px" style="left: 3px; position: relative; top: -110px"></asp:Label>
            &nbsp; &nbsp; &nbsp; &nbsp;<br />
            &nbsp;<asp:Button ID="Button11" runat="server" OnClick="Button11_Click" Text="位子確定" BackColor="White" ForeColor="#00C000" style="left: 0px; position: relative; top: -77px" />&nbsp;&nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="Button13" runat="server" Text="回座位區選擇" OnClick="Button13_Click" style="left: -25px; position: relative; top: -78px" />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="counttt"
                runat="server" Width="215px" style="left: -20px; position: relative; top: -78px"></asp:Label>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           
           &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

            &nbsp; &nbsp; &nbsp;&nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 
        </asp:Panel>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp;&nbsp;<br />
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        <asp:Image ID="Image1" runat="server" ImageUrl="picture/1.jpg" />&nbsp;<br />
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp;<br />
        &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp;&nbsp;&nbsp;<br />
        &nbsp; &nbsp; &nbsp;<br />
        <br />
        &nbsp;<asp:Label ID="sid" runat="server" Text="Label" Width="68px" Visible="False"></asp:Label><asp:Label ID="sname" runat="server" Text="Label" Width="57px" Visible="False"></asp:Label><asp:Label ID="scell" runat="server" Text="Label" Width="83px" Visible="False"></asp:Label><br />
        <br />
        &nbsp;<br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MOVIEConnectionString %>"
            SelectCommand="SELECT * FROM [time]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:seatConnectionString %>"
            DeleteCommand="DELETE FROM [seeat] WHERE [seat] = @seat" InsertCommand="INSERT INTO [seeat] ([seat], [confirm]) VALUES (@seat, @confirm)"
            SelectCommand="SELECT * FROM [seeat]" UpdateCommand="UPDATE [seeat] SET [confirm] = @confirm WHERE [seat] = @seat">
            <DeleteParameters>
                <asp:Parameter Name="seat" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="confirm" Type="String" />
                <asp:Parameter Name="seat" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="seat" Type="String" />
                <asp:Parameter Name="confirm" Type="String" />
            </InsertParameters>
    
        </asp:SqlDataSource>
    </form>
</body>
</html>
