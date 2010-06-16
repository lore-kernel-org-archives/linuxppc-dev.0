Return-Path: <B10812@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7C37B7D85
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 21:38:44 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5GBcgA3022386 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 04:38:42 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o5GBcj5a014447
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 06:38:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
Date: Wed, 16 Jun 2010 17:08:36 +0530
Message-ID: <8660DA277DC57B4BAAC78225F03146B6AB1BD3@zin33exm24.fsl.freescale.net>
In-Reply-To: <4C18B6AD.3030200@neli.hopto.org>
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
	<4C189860.3040702@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1BB3@zin33exm24.fsl.freescale.net>
	<4C18B6AD.3030200@neli.hopto.org>
From: "Aggrwal Poonam-B10812" <B10812@freescale.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@lists.ozlabs.org
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
> Sent: Wednesday, June 16, 2010 5:04 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
>=20
> Aggrwal Poonam-B10812 wrote:
> > Not sure of other platforms but on 85xx platforms on which I am
> > currently working u-boot does LAW and eLBC programming for 36bit
> > physical address. Hence possibly u-boot has to made aware of large
> > physical address space.
> > Please correct me if I am wrong.
>=20
> Yes, I can understand this for SDRAM and local flash interface. For
> RapidIO we have (local) patches to pass the law address range in the
dtb.
> Perhaps also for PCI-express this might be done; U-boot has nothing to
> with these high speed interfaces (in our case at least).
You are correct , for PCIe and SRIO kinds of interfaces Linux reprograms
the address windows.
Thanks
Poonam
>=20
> Micha
