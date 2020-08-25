<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankDetails.aspx.cs" Inherits="BankIFSC.Pages.BankDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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

            debugger;
            $.ajax({
                url: '../Services/BankDetails.asmx/GetAllStates',
                method: 'get',
                dataType: 'json',
                success: function (response) {
                    var ddlCustomers = $("[id*=ddlStates]");
                    console.log(response.length);
                    for (var i = 0; i < response.length; i++) {
                        ddlCustomers
                            .append(
                                '<option Value="' + response[i].ID + '">' + response[i].NAME + '</option>'
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

        function AddBranch() {
            debugger;
            var disid = $("#ddlDistricts option:selected").val();

            var d = '{Name: "' + $("#<%=txtBranchname.ClientID%>")[0].value + '",IFSC: "' + $("#<%=txtifsc.ClientID%>")[0].value + '", DistrictID: ' + disid + ', BanksID: ' + <%=ddlBankName.SelectedValue%> + '}';
            $.ajax({
                url: '../Services/BankDetails.asmx/AddNewBranch',
                method: 'get',
                dataType: 'json',
                data: { jsonData: d },
                statusCode: {
                    202: function () {
                        alert('Branch Added.')
                    },

                    501: function () {
                        alert('Branch not added.')
                    }
                }
            });
        }

        function GetDistrictsForStates() {
            debugger;
            $(".lst-clear").empty();
            var d = $("#ddlStates option:selected").val();
            $.ajax({
                url: '../Services/BankDetails.asmx/GetAllDistrictsForState',
                method: 'get',
                dataType: 'json',
                data: { stateID: d },
                success: function (response) {
                    var ddlCustomers = $("[id*=ddlDistricts]");
                    console.log(response.length);                    
                    for (var i = 0; i < response.length; i++) {
                        ddlCustomers
                            .append(
                                '<option Value="' + response[i].ID + '">' + response[i].NAME + '</option>'
                            )
                    };
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row w-100 m-2">
                            <label>State</label>
                            <asp:DropDownList CssClass="ml-2 w-50" ID="ddlStates" runat="server" onchange="GetDistrictsForStates()">
                                <asp:ListItem Value="0">Select State</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="row w-100 m-2">
                            <label>District</label>
                            <asp:DropDownList CssClass="ml-2 w-50 lst-clear" ID="ddlDistricts" runat="server">
                                <asp:ListItem Value="0">Select District</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="row w-100 m-2">
                            <label>Bank Name</label>
                            <asp:DropDownList CssClass="ml-2 w-50" ID="ddlBankName" runat="server">
                                <asp:ListItem Value="1">HDFC</asp:ListItem>
                                <asp:ListItem Value="2">PNB</asp:ListItem>
                                <asp:ListItem Value="3">SBI</asp:ListItem>
                                <asp:ListItem Value="4">IDFC</asp:ListItem>
                                <asp:ListItem Value="5">KOTAK MAHINDRA</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="row w-100 m-2">
                            <label>Branch Name</label>
                            <asp:TextBox CssClass="ml-2 w-50" ID="txtBranchname" runat="server" />
                        </div>
                        <div class="row w-100 m-2">
                            <label>IFSC Code</label>
                            <asp:TextBox CssClass="ml-2 w-50" ID="txtifsc" runat="server" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="AddBranch()">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="float-lg-right m-4">
            <input type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" value="Add Branch" />
            <button class="btn btn-secondary" onclick="">Log out</button>
        </div>
        <div class="container justify-content-md-center">
            <table class="table table-hover w-100">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Branch</th>
                        <th scope="col">IFSC</th>
                        <th scope="col">Bank Name</th>
                        <th scope="col">District</th>
                        <th scope="col">State</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody id="bankDetailsTable">
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
