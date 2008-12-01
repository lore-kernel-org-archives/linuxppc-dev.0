Return-Path: <RParsons@cbnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC8313 and Marvell PHY 88e1112
Date: Mon, 1 Dec 2008 12:31:30 -0000
Message-ID: <70635D41CDF67B48A35E0A8D5789806201E7CCB4@exchange.cbl.local>
In-Reply-To: <1227873994.3812.21.camel@parana>
References: <1227873994.3812.21.camel@parana>
From: "Richard Parsons" <RParsons@cbnl.com>
To: "Carlos Roberto Moratelli" <carlos.moratelli@digitel.com.br>,
	<Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Carlos,

I am using the Marvell 88E6097 Switch connected to a Freescale MPC8323
and I am using generic PHY mode on the Switch/PHY chip. There is an
appnote somewhere that says you need to force the link up in the marvell
if you are connecting using the MII bus (on this specific Ethernet PHY
though)=20

I done just that, and the MII bus came alive :-)

Richard=20


Cambridge Broadband Networks Limited
Registered in England and Wales under company number: 03879840 =
Registered office: Selwyn House, Cambridge Business Park, Cowley Road, =
Cambridge CB4 0WZ, UK.
VAT number: GB 741 0186 64

-----Original Message-----
From: linuxppc-embedded-bounces+rparsons=3Dcbnl.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+rparsons=3Dcbnl.com@ozlabs.org] On
Behalf Of Carlos Roberto Moratelli
Sent: 28 November 2008 12:07
To: Linuxppc-embedded@ozlabs.org
Subject: MPC8313 and Marvell PHY 88e1112

Hi,

I am working in a custom board based on a mpc8313erdb and my Kernel
version is 2.6.24. This board has a Marvell PHY 88E1112 on TSEC2
processor port.=20

The problem is that the PHY is detected and configured, but no data can
be send or received. I am sure that dtb is fine. In another custom board
I have a 88e3015 on TSEC2 and it is working fine.

Did someone work with this PHY? Does Compiling gianfar and Marvell
support on Kernel is enough?=20

Thanks,

Carlos R. Moratelli



_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
