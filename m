From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	<benh@kernel.crashing.org>, <akuster@mvista.com>
Subject: PPC4xx enet driver problem (version 2.0)
Date: Wed, 3 Dec 2003 12:29:31 +0100
Message-ID: <004901c3b990$b84d2ac0$0212000a@PCSTEFAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

We are trying to switch to the 2.4.23 linuxppc_2_4_devel kernel (from
2.4.21) and experience a problem with the "new" ethernet driver for the
ibm ppc4xx (version 2.0 from Benjamin Herrenschmidt). On our boards with
only one active enet interface we have no problems. But our PPC405EP
boards with 2 active enet devices, the traffic stops completely upon
initializing the 2nd devices (emac_reset_configure).

Has anybody experienced similar problems? Has anybody seen this driver
working properly with more than one ppc4xx enet devices (especially
ppc405ep)?

With the previous driver (from linuxppc_2_4_devel 2.4.21 maintained by
mvista) we had no problems with 2 enet interfaces on the ppc405ep so
far!

By the way: What is the future of the ppc4xx enet driver. I found that
the 2.5 kernel  has a newer mvista driver included (modifications for
440gx, etc.). Is the driver from 2.4.23 a dead end?

Thanks and best regards,
Stefan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
