Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4352CDDD05
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 00:50:50 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6DEoj74014400
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:50:45 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6DEohl9026667
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 09:50:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Update mpc7448hpc2 device tree to be compatible fortsi109
	chip
Date: Fri, 13 Jul 2007 22:50:42 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E90B42C@zch01exm23.fsl.freescale.net>
In-Reply-To: <1184332262.6456.7.camel@weaponx.rchland.ibm.com>
References: <1184299081.30789.9.camel@localhost.localdomain>
	<1184332262.6456.7.camel@weaponx.rchland.ibm.com>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On Fri, 2007-07-13 at 11:58 +0800, Zang Roy-r61911 wrote:
> > From: Roy Zang <tie-fei.zang@freescale.com>
> >=20
> > Update mpc7448hpc2 device tree to be compatible for tsi109 chip.
>=20
> Are there any actual changes in the drivers or platform files for
> tsi109?=20
No!
> I seem to recall that Linux treated tsi108 and tsi109
> identically at the moment.
Your are right!
>=20
> If there are changes coming that differentiate tsi109 and=20
> tsi108, please
> CC me on those so I can update the Holly board as well.=20
I will :-)
Roy
