Message-ID: <002c01c3399b$51924380$7400a8c0@CCH>
From: "Christian Charreyre - CIO" <christian.charreyre@cioinfoindus.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with 8250 in promiscuous mode : Ethernet received frames losts
Date: Mon, 23 Jun 2003 17:22:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working with a custom board based on 8250 PPC.
It's using the fcc_enet.c driver on Linux 2.4.18 from Elinos distribution
(version 0.3 of the driver).

I face the following problem :

When sending 802.3 frames from a PowerMac, and receiving them on my custom
board in promiscuous mode, about 10% of the frames are lost.

Does anyone know if the driver has bugs when working in promiscuous mode,
that could explain such a phenomen ?

Is this version of the driver the up to date version (looking in sources
from RedHat Linux 9 for PPC, it seems that the driver version is only 0.2) ?

Thanks for help or hints.


Christian Charreyre

--


CIO Informatique Industrielle

11 Avenue Marigny
13014 Marseille

Tél : 04 95 05 19 41
Fax : 04 95 05 19 42


1 rue de la Presse - BP 710
42950 St Etienne Cedex 9

Tél : 04 77 93 34 32
Fax : 04 77 79 75 55

mailto:christian.charreyre@cioinfoindus.fr
http://www.cioinfoindus.fr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
