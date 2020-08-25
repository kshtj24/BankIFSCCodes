<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankDetails.aspx.cs" Inherits="BankIFSC.Pages.BankDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: '../Services/BankDetails.asmx/GetAllBankBranches',
                method: 'get',
                dataType: 'json',                
                success: function (response) {
                    for (var i = 0; i < response.length; i++) {
                        $('#bankDetailsTable')
                            .append(
                                '<tr>' + '<th scope="row">' + response[i].ID + '</th>'
                                + '<td>' + response[i].BRANCH + '</td>'
                                + '<td>' + response[i].IFSC + '</td>'
                                + '<td>' + response[i].BANKNAME + '</td>'
                                + '<td>' + response[i].DISTRICT + '</td>'
                                + '<td>' + response[i].STATE + '</td>'
                                + '<td>' + '<input type="button" id="' + response[i].ID + '" value="Delete" onclick="DeleteBranch(this.id)">' + '</td>'
                            )
                    };
                }
            });
        });

        function DeleteBranch(id) {
            debugger;
            $.ajax({
                url: '../Services/BankDetails.asmx/DeleteBranch',
                method: 'get',
                dataType: 'json',
                data: { id: id },
                statusCode: {
                    202: function () {
                        alert('Branch Deleted.')
                    },

                    501: function () {
                        alert('Branch not deleted.')
                    }
                }
            });

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container m-5">
            <table class="table w-100">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Branch</th>
                        <th scope="col">IFSC</th>
                        <th scope="col">Bank Name</th>
                        <th scope="col">District</th>
                        <th scope="col">State</th>
                    </tr>
                </thead>
                <tbody id="bankDetailsTable">
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
