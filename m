MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 82xx and cache coherency between CPM and CPU
Date: Mon, 9 Aug 2004 16:35:45 +0200
Message-ID: <F656466568DBEB459CFCADE46C5EADDC4C9986@foconexch.focon.local>
From: "Peter Krogsgaard" <PKA@Focon.dk>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have been browsing through the driver code for the MPC8260 from the
cvs
repository at denx.de (linuxppc_2_4_devel).

One thing that makes me wonder is why some of the drivers (i2c, spi)
calls
flush_dcache_range and friends instead of setting the gobal access bit
(GBL)
in the rfcr/tfcr registers for the device?

As I read the docs the 82xx are cache coherent between the CPU and the
CPM so
the GBL bit should do the trick.

Am I missing something obvious here ?


Best regards

Peter Krogsgaard
Focon Electronic Systems A/S


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
