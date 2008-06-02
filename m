Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EED9FDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jun 2008 19:42:11 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m529g5Cr027583
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 Jun 2008 02:42:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m529g2wn026746
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 Jun 2008 04:42:03 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: USB Host-to-Serial or USB Host-to-Ethernet
Date: Mon, 2 Jun 2008 17:42:01 +0800
Message-ID: <989B956029373F45A0B8AF02970818900250DC6C@zch01exm26.fsl.freescale.net>
In-Reply-To: <BAY122-W337F19C2D451B0405A1391DABB0@phx.gbl>
References: <BAY122-W428F4FD4AED8DAED5968A1DABF0@phx.gbl><200805291414.26798.laurentp@cse-semaphore.com>
	<BAY122-W337F19C2D451B0405A1391DABB0@phx.gbl>
From: "Li Yang" <LeoLi@freescale.com>
To: "Huub Eikens" <huubeikens@hotmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o
> rg] On Behalf Of Huub Eikens
> Sent: Monday, June 02, 2008 5:22 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: USB Host-to-Serial or USB Host-to-Ethernet
>=20
> Hi,
> =20
> I have platform based on the Freescale MPC8270 processor that=20
> runs on linux 2.4.25. On it I want to mount a memory stick.=20
> Due to hardware (layout) restrictions , I cannot use an=20
> external USB Host Controller. Also, I cannot use the on-chip=20
> USB Host Controller since there is no driver available that=20
> is reliable and has good performance.
> =20
> Therefor, I am exploring the possibility of doing a=20
> USB-to-Serial or USB-to-ethernet. Does anyone know which chip=20
> to use for which a driver exists for linux 2.4.25? Note that=20
> such a chip must act as a USB Host (!).=20

Can you use a PCI USB card?  I don't quite understand how USB-to-serial =
or USB-to-ethernet can help you mount a USB memory stick.  Unless you =
want USB memory stick to be mounted on another system and exported with =
NFS.

- Leo
