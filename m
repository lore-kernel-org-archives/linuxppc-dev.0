Message-ID: <39864DEA.9A9B89C6@embeddededge.com>
Date: Tue, 01 Aug 2000 00:11:22 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Embedded and 2.4.0-test5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just pushed the latest version of the 8260 FCC Ethernet driver.
The MII/MDIO for PHY control status is not complete and is very
board specific.  I am testing the funky MDIO pulse for interrupt,
which people claim will work.....we'll see.

I found trouble with the inclusion of the drivers/macintosh
directory that is automatically included with CONFIG_PPC.  I had
to remove this from the Makefiles, and I am now working with the
workstation folks to find a solution.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
