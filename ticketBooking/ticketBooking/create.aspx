<%@ Page Language="VB" %>
<%@ import namespace="System.Data" %>
<%@ import namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim settingsin As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatConnectionString")
        Dim objconnsin As New SqlConnection(settingsin.ConnectionString)
        Dim objcmdsin As New SqlDataAdapter("select * from seeat", objconnsin)
        Dim objcbsin As SqlCommandBuilder = New SqlCommandBuilder(objcmdsin)
        Dim dssin As New DataSet()
        objcmdsin.Fill(dssin, "seeat")
        Dim mytable2 As DataTable = dssin.Tables("seeat")
        
        For i As Integer = 0 To mytable2.Rows.Count - 1
         
            mytable2.Rows(i).Delete()
            
        Next
        objcmdsin.Update(mytable2.Select(Nothing, Nothing, DataViewRowState.Deleted))
        
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim setting1 As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("MOVIEConnectionString")
        Dim setting2 As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatConnectionString")
        
        Dim objconn1 As New SqlConnection(setting1.ConnectionString)
        Dim objconn2 As New SqlConnection(setting2.ConnectionString)
        
        Dim objcmd1 As New SqlDataAdapter("select * from time", objconn1)
        Dim objcmd2 As New SqlDataAdapter("select * from seeat", objconn2)
        
        Dim objcb1 As SqlCommandBuilder = New SqlCommandBuilder(objcmd1)
        Dim objcb2 As SqlCommandBuilder = New SqlCommandBuilder(objcmd2)
       
        
        Dim ds1 As New DataSet()
        Dim ds2 As New DataSet()
        objcmd1.Fill(ds1, "time")
        objcmd2.Fill(ds2, "seeat")
        Dim mytable1 As DataTable = ds1.Tables("time")
        Dim mytable2 As DataTable = ds2.Tables("seeat")
       
        For i As Integer = 0 To mytable1.Rows.Count - 1
          
           
            For j As Integer = 2 To mytable1.Columns.Count - 1
                
                For k As Integer = 1 To 104
                    Dim myrow As DataRow = mytable2.NewRow()
                    myrow("電影代號") = mytable1.Rows(i).Item(0)
                    myrow("時間") = mytable1.Rows(i).Item(j)
                    If k < 17 Then
                        myrow("座位區") = "a"
                        myrow("seat") = k
                    End If
                    If k < 49 And k > 16 Then
                        myrow("座位區") = "b"
                        myrow("seat") = k - 16
                    End If
                    If k < 81 And k > 48 Then
                        myrow("座位區") = "c"
                        myrow("seat") = k - 48
                    End If
                    If k < 93 And k > 80 Then
                        myrow("座位區") = "d"
                        myrow("seat") = k - 80
                    End If
                    If k < 105 And k > 92 Then
                        myrow("座位區") = "e"
                        myrow("seat") = k - 92
                    End If
                   
                    myrow("confirm") = "n"
                    
                    myrow("Id")="none"
                   
                    mytable2.Rows.Add(myrow)
                    
                  
                Next k
              
                
            
            Next j
         
        Next i
       
        objcmd2.Update(mytable2.Select(Nothing, Nothing, DataViewRowState.Added))
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim setting1 As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("MOVIEConnectionString")
        Dim setting2 As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatConnectionString")
        Dim setting3 As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("seatConnectionString")
       
        
        Dim objconn1 As New SqlConnection(setting1.ConnectionString)
        Dim objconn2 As New SqlConnection(setting2.ConnectionString)
        Dim objconn3 As New SqlConnection(setting3.ConnectionString)
        
       
        Dim objcmd1 As New SqlDataAdapter("select * from time", objconn1)
        Dim objcmd2 As New SqlDataAdapter("select * from seeat", objconn2)
        Dim objcmd3 As New SqlDataAdapter("select * from information", objconn3)
       
        
        Dim objcb1 As SqlCommandBuilder = New SqlCommandBuilder(objcmd1)
        Dim objcb2 As SqlCommandBuilder = New SqlCommandBuilder(objcmd2)
        Dim objcb3 As SqlCommandBuilder = New SqlCommandBuilder(objcmd3)
       
        
        Dim ds1 As New DataSet()
        Dim ds2 As New DataSet()
        Dim ds3 As New DataSet()
       
       
        objcmd1.Fill(ds1, "time")
        objcmd2.Fill(ds2, "seeat")
        objcmd2.Fill(ds3, "information")
       
       
        Dim mytable1 As DataTable = ds1.Tables("time")
        Dim mytable2 As DataTable = ds2.Tables("seeat")
        Dim mytable3 As DataTable = ds3.Tables("information")
        
              
            
            
            
        Dim k1 As Integer = 1
        Dim k2 As Integer = 104
        Dim count As Integer = 0 'test
        For k As Integer = 0 To mytable1.Rows.Count - 1
            For j As Integer = 2 To mytable1.Columns.Count - 1
           
            
                Dim a As Integer
                a = mytable2.Rows.Count / 104
 
                
                If k2 / 104 < a Then
               
                    For i As Integer = k1 To k2
          
         
                        If mytable2.Rows(i - 1).Item(2) <> mytable1.Rows(k).Item(j) Then
                            '只改限定資料
                          
                            '刪除information人員資料
                            For m As Integer = 0 To mytable3.Rows.Count - 1
                                If mytable3.Rows(m).Item("Id") = mytable2.Rows(k).Item("Id") Then
                            
                                    mytable3.Rows(i).Delete()
                                    objcmd3.Update(mytable3.Select(Nothing, Nothing, DataViewRowState.Deleted))
                                End If
                                                                               
                            Next m
                            '將seeat時間修改
                            mytable2.Rows(i - 1).Item(2) = mytable1.Rows(k).Item(j)
                            '將Id ,confirm 歸零
                            mytable2.Rows(i - 1).Item(6) = "none"
                            mytable2.Rows(i - 1).Item(5) = "n"
                          
                        Else
                            count = count + 1
                        End If
                       
          
                    Next i
               
                    k1 = k2 + 1
                    k2 = k2 + 104
                End If
       
       
            Next j
                
        Next k
        Response.Write(count)
        objcmd2.Update(mytable2.Select(Nothing, Nothing, DataViewRowState.ModifiedCurrent))
   
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="場次管理介面"></asp:Label><br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="create" OnClick="Button1_Click" />
        <asp:Label ID="Label4" runat="server" Text="從電影場次重新創造座位"></asp:Label>&nbsp;<br />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="delete" />&nbsp;
        <asp:Label ID="Label2" runat="server" Text="清空刪除所有座位"></asp:Label><br />
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="modify" />
        &nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="更新場次座位" Width="124px"></asp:Label></div>
    </form>
</body>
</html>
