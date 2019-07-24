using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestDrive1
{
    class Program
    {
        static void Main(string[] args)
        {
            // Please keep your IE configuration settings:
            // 1. Check on "Enable Protected Mode" at ALL zones in "Security" tab of Internet Options dialog.
            // 2. Browser zoom level keep to 100%.
            var driverService = OpenQA.Selenium.IE.InternetExplorerDriverService.CreateDefaultService(AssemblyDirectory, "IEDriverServer64.exe");
            driverService.HideCommandPromptWindow = false;

            using (var driver = new OpenQA.Selenium.IE.InternetExplorerDriver(driverService))
            {
                driver.Navigate().GoToUrl("https://www.bing.com/");
                driver.FindElementById("sb_form_q").SendKeys("Selenium WebDriver");
                driver.FindElementById("sb_form_go").Click();

                Console.WriteLine("OK");
                Console.ReadKey(intercept: true);
            }
        }
        public static string AssemblyDirectory
        {
            get
            {
                string codeBase = System.Reflection.Assembly.GetExecutingAssembly().CodeBase;
                UriBuilder uri = new UriBuilder(codeBase);
                string path = Uri.UnescapeDataString(uri.Path);
                return System.IO.Path.GetDirectoryName(path);
            }
        }
    }
}
