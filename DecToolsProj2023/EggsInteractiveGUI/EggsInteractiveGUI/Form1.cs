using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace EggsInteractiveGUI
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        private void btnCalculate_Click(object sender, EventArgs e)
        {
            try
            {
                // Set the size of a dozen
                const int DOZEN = 12;

                // Grab the textbox contents, convert them to integers, add them all together
                int intTotal = int.Parse(txtEggs1.Text) + int.Parse(txtEggs2.Text) +
                    int.Parse(txtEggs3.Text) + int.Parse(txtEggs4.Text) +
                    int.Parse(txtEggs5.Text);

                // Calculate how many "dozens" of eggs there are
                int intDozen = intTotal / DOZEN;

                // Calculate how many leftover eggs are not part of a full dozen
                int intLeftOver = intTotal % DOZEN;

                // Display the results
                lblResult.Text = intTotal + " eggs is " + intDozen + " dozen with " + intLeftOver + " left over";
            }
            catch
            {
                lblResult.Text = "All textboxes must contain a number.";
            }
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

    }
}
