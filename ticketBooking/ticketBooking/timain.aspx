<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("ticketsit.aspx")
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("create.aspx")
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("manage1.aspx")
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;<br />
        <br />
        <br />
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/ticketsit.aspx">前往訂位系統</asp:LinkButton><br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="前往訂位系統" OnClick="Button1_Click" /><br />
        <br />
        <br />
        <asp:Panel ID="Panel2" runat="server" Height="222px" Width="278px" Visible="False">
            <asp:Label ID="Label2" runat="server" Text="管理者登入"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="帳號"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>&nbsp;
            <br />
            <asp:Label ID="Label4" runat="server" Text="密碼"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
            <br />
            <br />
            <asp:Button ID="Button4" runat="server" Text="登入" />&nbsp;
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel1" runat="server" Height="103px" Width="229px">
            <asp:Button ID="Button2" runat="server" Text="場次管理" OnClick="Button2_Click" />
            <asp:Button ID="Button3" runat="server" Text="訂票管理" OnClick="Button3_Click" /></asp:Panel>
    
    </div>
    </form>
</body>
</html>
