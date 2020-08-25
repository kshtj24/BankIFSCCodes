using BankIFSC.Helpers;
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Web.Script.Services;
using System.Web.Services;

namespace BankIFSC.Services
{
    [System.Web.Script.Services.ScriptService]
    public class UserAuthentication : WebService
    {
        private static string conn = ConfigurationManager.ConnectionStrings["appdb"].ConnectionString;

        private bool UserExists(string userid)
        {
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(string.Format(Queries.USEREXISTS, userid)))
                {
                    try
                    {
                        con.Open();
                        cmd.Connection = con;
                        var result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            return true;
                        }

                        else
                        {
                            return false;
                        }
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        [WebMethod]
        public void AuthenticateUser(string jsonData)
        {

            var obj = JsonConvert.DeserializeObject<User>(jsonData);

            if (!UserExists(obj.userid))
            {
                Context.Response.StatusCode = (int)HttpStatusCode.NoContent;
            }
            else
            {
                using (SqlConnection con = new SqlConnection(conn))
                {
                    using (SqlCommand cmd = new SqlCommand(string.Format(Queries.AUTHENTICATEUSER, obj.userid, obj.password)))
                    {
                        try
                        {
                            con.Open();
                            cmd.Connection = con;
                            var result = cmd.ExecuteScalar();

                            if (result != null)
                            {
                                Context.Response.StatusCode = (int)HttpStatusCode.OK;
                            }

                            else
                            {
                                Context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                            }
                        }
                        catch (Exception e)
                        {
                            Context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                        }
                        finally
                        {
                            con.Close();
                        }
                    }
                }
            }
        }
    }
}
