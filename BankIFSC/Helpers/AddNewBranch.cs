using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BankIFSC.Helpers
{
    public class AddNewBranch
    {
        public string Name { get; set; }
        public int IFSC { get; set; }
        public int DistrictID { get; set; }
        public int BanksID { get; set; }
    }
}