Date: Fri, 4 Feb 2000 13:31:18 -0500
From: Rich Lafferty <rich@alcor.concordia.ca>
To: Linux Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Easy question about drivers
Message-ID: <20000204133118.B1272@alcor.concordia.ca>
References: <B4C07534.2AA2%Moridin@psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B4C07534.2AA2%Moridin@psu.edu>; from Moridin@psu.edu on Fri, Feb 04, 2000 at 12:23:16PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 04, 2000 at 12:23:16PM -0500, Michael Willhide (Moridin@psu.edu) wrote:
>
> Are video cards considered character devices?

$ ls -l /dev/fb0
crw-------   1 rich     root      29,   0 Jun 25  1999 /dev/fb0
^

Yup. :-)

  -Rich

--
------------------------------ Rich Lafferty ---------------------------
 Sysadmin/Programmer, Instructional and Information Technology Services
   Concordia University, Montreal, QC                 (514) 848-7625
------------------------- rich@alcor.concordia.ca ----------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
