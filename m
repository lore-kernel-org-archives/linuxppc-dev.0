From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Commit" <linuxppc-commit@source.mvista.com>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: status of linuxppc_2_4_devel for ppc405gp
Date: Wed, 22 Aug 2001 12:22:52 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I recently noticed that some new stuff for the ppc4xx found its way into the
linuxppc_2_4_devel tree (thanks dan).

So I tried to port this linux-tree to our custom ppc405gp board. Up to now
we are using the MontaVista Linux for the ppc405gp (walnut) from 03-2001.

Within this process I found some problems:

Our system crashes in the function "ppc4xx_gdb_init()" in file
"ppc4xx_setup.c". Without this call bootup look much better ;-). Any
comments on this?

I noticed that the ppc405_enet driver is not compiled and not started
(Makefile and Space.c in drivers/net). Is there a patch missing?

Is anybody running this linuxppc_2_4_devel on a walnut board or custom
ppc405 board? What is the "official status" of the ppc405 support in this
linux tree?

Thanks and best regards,
Stefan Roese


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
