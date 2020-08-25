using BankIFSC.Helpers;
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Web.Script.Services;
using System.Web.Services;

namespace BankIFSC.Services
{
    [ScriptService]
    public class BankDetails : WebService
    {
        private string conn = ConfigurationManager.ConnectionStrings["appdb"].ConnectionString;

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void GetAllBankBranches()
        {
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(Queries.GETALLBRANCHES))
                {
                    try
                    {
                        con.Open();
                        cmd.Connection = con;
                        DataTable dataTable = new DataTable();

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dataTable);
                        }

                        Context.Response.StatusCode = (int)HttpStatusCode.OK;
                        Context.Response.Write(JsonConvert.SerializeObject(dataTable, Formatting.Indented));
                    }
                    catch (Exception ex)
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

        [WebMethod]
        [ScriptMethod(UseHttpGet =true, ResponseFormat=ResponseFormat.Json)]
        public void GetAllDistrictsForState(int stateID)
        {
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(string.Format(Queries.GETALLDISTRICTSFORSTATE, stateID)))
                {
                    try
                    {
                        con.Open();
                        cmd.Connection = con;
                        DataTable dataTable = new DataTable();

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dataTable);
                        }

                        Context.Response.StatusCode = (int)HttpStatusCode.OK;
                        Context.Response.Write(JsonConvert.SerializeObject(dataTable, Formatting.Indented));
                    }
                    catch (Exception ex)
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

        [WebMethod]
        [ScriptMethod]
        public void AddNewBranch(string jsonData)
        {
            var obj = JsonConvert.DeserializeObject<AddNewBranch>(jsonData);

            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(string.Format(Queries.ADDNEWBRANCH, obj.Name, obj.IFSC, obj.DistrictID, obj.BanksID)))
                {
                    try
                    {
                        con.Open();
                        cmd.Connection = con;
                        var result = cmd.ExecuteNonQuery();

                        if (int.Parse(result.ToString()) > 0)
                            Context.Response.StatusCode = (int)HttpStatusCode.Created;
                        else
                            Context.Response.StatusCode = (int)HttpStatusCode.NotImplemented;
                    }
                    catch (Exception ex)
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

