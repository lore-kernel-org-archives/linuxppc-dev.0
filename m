Message-ID: <3810F8F6.B831114B@netx4.com>
Date: Fri, 22 Oct 1999 19:53:26 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx updates to 2.2.13
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just put a tar image of 2.2.13 with the 8xx updates on
ppc.kernel.org.  I needed it for a couple of real applications....

It has a few things in it that I have yet to check into the 2.3.xx
baseline.  In particular there are a couple of 10/100 Ethernet
PHYs I want to ensure work properly.  There are also CPM port
configurations I want to complete.

I tested it on the MBX, BrightStar Engineering BSE-IP, and the
Embedded Planet RPX-CLLF.  If you are using the CLLF, there is
some additional information about booting over the 10/100 Ethernet
on the FEC that may be helpful.  Ask and I will post that in
a separate message so it doesn't get lost here.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
