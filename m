Message-ID: <381069AF.655D9989@phx.mcd.mot.com>
Date: Fri, 22 Oct 1999 06:42:07 -0700
From: Dan Sheets <dans@phx.mcd.mot.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: More on PREP IDE Fixes
Content-Type: multipart/mixed;
 boundary="------------241D1922E0E7FAAF3ADA769F"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------241D1922E0E7FAAF3ADA769F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Cort asked me to ask people to test these changes. 
Cort is planning on putting these changes in unless 
people can find problems with the modifications.

Could someone else please try out these changes? 

I've attached the diff. This diff is against vger 2.2,
Cort's request.

Since my original post I found an old Blackhawk 
(PowerStack) that has IDE. I tried my original patch
on this board and it didn't work. Well, come to find
out the standard 2.2 PPC kernel also didn't support
IDE. So in the patch that's attached, I have also fixed
IDE on a Blackhawk.

I have tested this patch on a MTX, MCP750, MCPN750
and a Blackhawk.

Thanks
-- 
___________________________________________________________________
Dan Sheets                          Motorola Computer Group
Software Engineer, RTSS             2900 South Diablo Way, MD DW278
dans@phx.mcd.mot.com                Tempe, AZ 85282
--------------241D1922E0E7FAAF3ADA769F
Content-Type: encoding/x-gzip;
 name="vger2.2Ide.udiff.gz"
Content-Disposition: inline;
 filename="vger2.2Ide.udiff.gz"
Content-Transfer-Encoding: base64

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
--------------241D1922E0E7FAAF3ADA769F--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
