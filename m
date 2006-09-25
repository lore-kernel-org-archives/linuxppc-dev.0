Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 6DABC67B74
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 03:09:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to move from /ppc/ to /powerpc/
Date: Mon, 25 Sep 2006 18:56:54 +0200
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9399B481B@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Fredrik Roubert" <roubert@df.lth.se>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > I tried compiling it like this:
>=20
> $ dtc -f -I dts -O dtb mpc8349emds.dts > devices.dtb
> DTC: dts->dtb  on file "mpc8349emds.dts"
> Warning: No cpu has "linux,boot-cpu" property
> ERROR: Missing /chosen node
> Input tree has errors

You need to add -V 0x10 to dtc as well.
