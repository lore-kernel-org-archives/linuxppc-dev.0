Return-Path: <B10812@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F6B81007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 20:49:40 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5GAnbOM027110 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 03:49:37 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o5GAnf84000967
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 05:49:42 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
Date: Wed, 16 Jun 2010 16:19:33 +0530
Message-ID: <8660DA277DC57B4BAAC78225F03146B6AB1BB3@zin33exm24.fsl.freescale.net>
In-Reply-To: <4C189860.3040702@neli.hopto.org>
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
	<4C189860.3040702@neli.hopto.org>
From: "Aggrwal Poonam-B10812" <B10812@freescale.com>
To: "Micha Nelissen" <micha@neli.hopto.org>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Micha Nelissen [mailto:micha@neli.hopto.org]
> Sent: Wednesday, June 16, 2010 2:55 PM
> To: Aggrwal Poonam-B10812; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
>=20
> Aggrwal Poonam-B10812 wrote:
> >> Attached is a patch to fix large physical address support for the
> >
> > This is already being done by u-boot, should linux set it again?
>=20
> Yikes! Took me 5 min to reformat your email.
>=20
> Our version of U-boot does not but it's not latest greatest.
>=20
> IMHO:
> 1) Linux should not be dependent on U-boot or any other bootloader, or
at
> least as possible
> 2) U-boot cannot (and does not want to) know whether Linux is going to
> use large physical addresses.
>=20
Not sure of other platforms but on 85xx platforms on which I am
currently working u-boot does LAW and eLBC programming for 36bit
physical address. Hence=20
possibly u-boot has to made aware of large physical address space.
Please correct me if I am wrong.
> Regards,
>=20
> Micha
