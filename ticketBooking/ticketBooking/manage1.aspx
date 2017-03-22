<%@ Page Language="VB" %>
<%@ import namespace="System.Data" %>
<%@ import namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        
        Dim settingsit As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconnsit As New SqlConnection(settingsit.ConnectionString)
        Dim objcmdsit As New SqlDataAdapter("select * from seeat", objconnsit)
        Dim objcbsit As SqlCommandBuilder = New SqlCommandBuilder(objcmdsit)
        Dim dssit As New DataSet()
        objcmdsit.Fill(dssit, "seeat")
        Dim mytable As DataTable = dssit.Tables("seeat")
        
      
        CheckBoxList1.Visible = True
        RadioButtonList1.Visible = False
        
        CheckBoxList1.Enabled = False
      
        CheckBoxList1.Items.Clear()
       
        For i As Integer = 0 To mytable.Rows.Count - 1
            If mytable.Rows(i).Item("confirm") = "y" Then
                CheckBoxList1.Items.Add(New ListItem("電影代號:" & mytable.Rows(i)("電影代號") & " 時間:" & mytable.Rows(i)("時間") & "座位區:" & mytable.Rows(i)("座位區") & "sitno." & mytable.Rows(i)("seat") & " ID:" & mytable.Rows(i)("ID"), mytable.Rows(i)("流水號")))
            
            End If
        Next i

     
        
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Panel1.Visible = True
        
    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim settingsit As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconnsit As New SqlConnection(settingsit.ConnectionString)
        Dim objcmdsit As New SqlDataAdapter("select * from seeat", objconnsit)
        Dim objcbsit As SqlCommandBuilder = New SqlCommandBuilder(objcmdsit)
        Dim dssit As New DataSet()
        objcmdsit.Fill(dssit, "seeat")
        Dim mytable As DataTable = dssit.Tables("seeat")
    
        Dim settingsin As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconnsin As New SqlConnection(settingsin.ConnectionString)
        Dim objcmdsin As New SqlDataAdapter("select * from information", objconnsin)
        Dim objcbsin As SqlCommandBuilder = New SqlCommandBuilder(objcmdsin)
        Dim dssin As New DataSet()
        objcmdsin.Fill(dssin, "seeat")
        Dim mytable2 As DataTable = dssin.Tables("seeat")
        Dim switchi As Integer = 0
        
        If TextBox1.Text <> "" Then
            For i As Integer = 0 To mytable.Rows.Count - 1
                If mytable.Rows(i).Item("Id") = TextBox1.Text Then
              
                    mytable.Rows(i).Item("confirm") = "n"
                    mytable.Rows(i).Item("Id") = "none"
                    objcmdsit.Update(mytable.Select(Nothing, Nothing, DataViewRowState.ModifiedCurrent))
                    
                    switchi = 1
                Else
                    
                End If
               
            Next i
            If switchi = 1 Then
                Response.Write("成功刪除該筆Id(身份證)訂位及票種數量" & TextBox1.Text)
            End If
            Dim jswitch As Integer = 0
            For j As Integer = 0 To mytable2.Rows.Count - 1
                If jswitch = 0 Then
                    If mytable2.Rows(j).Item("Id") = TextBox1.Text And jswitch = 0 Then
            
                        mytable2.Rows(j).Delete()
                
                        objcmdsin.Update(mytable2.Select(Nothing, Nothing, DataViewRowState.Deleted))
                   
                        jswitch = 1
                    End If
                End If
            Next j
        
        
            
            
        Else
            Response.Write("輸入不正確")
        End If
        
    End Sub


    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim settingsin As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatconnectionstring")
        Dim objconnsin As New SqlConnection(settingsin.ConnectionString)
        Dim objcmdsin As New SqlDataAdapter("select * from information", objconnsin)
        Dim objcbsin As SqlCommandBuilder = New SqlCommandBuilder(objcmdsin)
        Dim dssin As New DataSet()
        objcmdsin.Fill(dssin, "information")
        Dim mytable2 As DataTable = dssin.Tables("information")
      
        RadioButtonList1.Visible = True
        CheckBoxList1.Visible = False
        
        RadioButtonList1.Enabled = False
        RadioButtonList1.Items.Clear()
       
        
        For i As Integer = 0 To mytable2.Rows.Count - 1
            RadioButtonList1.Items.Add(New ListItem("姓名" & mytable2.Rows(i).Item("name") & " Id: " & mytable2.Rows(i).Item("Id") & "全票" & mytable2.Rows(i).Item("normal") & "學生" & mytable2.Rows(i).Item("studnt"), mytable2.Rows(i).Item("Id")))
            
        Next
        
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <asp:Label ID="Label1" runat="server" Text="訂票座位管理介面"></asp:Label><br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="座位資料狀況" Width="97px" />&nbsp;<asp:Button
            ID="Button5" runat="server" Text="顧客票種資訊" Width="108px" OnClick="Button5_Click" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="取消訂位(依身份證字號)"
            Width="159px" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />
        &nbsp;<asp:CheckBoxList ID="CheckBoxList1" runat="server" Visible="False">
        </asp:CheckBoxList>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" Visible="False">
        </asp:RadioButtonList>&nbsp;<br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <asp:Panel ID="Panel1" runat="server" Height="50px" Visible="False" Width="271px">
            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click"
            Text="確認" />
        <asp:TextBox ID="TextBox1" runat="server">在此輸入ID</asp:TextBox></asp:Panel>
    </div>
    </form>
</body>
</html>
