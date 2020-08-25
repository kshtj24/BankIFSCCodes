using BankIFSC.Helpers;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Management.Instrumentation;
using System.Net;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankIFSC.Pages
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private static string conn = ConfigurationManager.ConnectionStrings["appdb"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        protected void login_btn_Click(object sender, EventArgs e)
        {
            
        }
    }
}