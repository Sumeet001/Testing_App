using Microsoft.VisualStudio.TestTools.UnitTesting;
using Testing_App;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Testing_App.Tests
{
    [TestClass()]
    public class SumeetTests
    {
        [TestMethod()]
        public void SumTest()
        {
            Sumeet t = new Sumeet();
            Assert.AreEqual(t.Sum(2, 3), 6);
        }
    }
}