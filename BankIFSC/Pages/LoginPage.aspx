<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="BankIFSC.Pages.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnlogin').click(function () {
                var d = '{userid: "' + $("#<%=txtUserName.ClientID%>")[0].value + '", password: "' + $("#<%=txtpass.ClientID%>")[0].value + '"}';
                $.ajax({
                    url: '../Services/UserAuthentication.asmx/AuthenticateUser',
                    data: { jsonData: d },
                    method: 'post',
                    dataType: 'json',
                    statusCode: {
                        200: function () {
                            alert('Login Successful !');
                            document.location.href = 'BankDetails.aspx';
                        },

                        401: function () {
                            alert('Invalid login credentials, please try again');
                        },

                        204: function () {
                            alert("User doesn't exist.")
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
    <form id="login_form" runat="server">
        <div class="container m-5">
            <div class="row justify-content-md-center">
                <h2>LOG IN</h2>
            </div>

            <div class="row justify-content-md-center">
                <asp:TextBox ID="txtUserName" runat="server" class="form-control col col-lg-3" placeholder="User ID" />
            </div>
            <div class="row justify-content-md-center">
                <asp:TextBox ID="txtpass" runat="server" class="form-control col col-lg-3 mt-3" placeholder="Password" />
            </div>
            <div class="row justify-content-md-center">
                <input id="btnlogin" class="form-control col col-lg-3 mt-3 btn btn-primary" type="button" value="Log In" />
            </div>
        </div>
    </form>
</body>
</html>
