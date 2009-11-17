Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62218B7063
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 20:40:56 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAH9epZr015558
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 02:40:52 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nAH9j3Bt013060
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 03:45:05 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
Date: Tue, 17 Nov 2009 15:11:25 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A08012220BC@zin33exm23.fsl.freescale.net>
In-Reply-To: <4B0253CF.3090506@garzik.org>
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
	<da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com>
	<F2F605B667B24B489C904986E0D60A08012220A2@zin33exm23.fsl.freescale.net>
	<4B0253CF.3090506@garzik.org>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Jeff Garzik" <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Grant Grundler <grundler@google.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Jeff Garzik [mailto:jeff@garzik.org]=20
> Sent: Tuesday, November 17, 2009 1:12 PM
> > In this case "msi" is supposed to be passed via insmod and not via=20
> > kernel cmdline. If the driver is built-in the kernel, then force=20
> > sata_sil24_msi =3D 1 in the driver to enable it.
>=20
> First, the original patch was just fine, and it was applied. =20
> You should have received email confirmation of this already.

Yes, I did.

> Second, all module options are available on the kernel=20
> command line, when a module is built into the kernel.  You=20
> supply a module name prefix to each module option, on the=20
> kernel command line.

Correct, sata_sil24.msi enables it.

>=20
> 	Jeff

Thanks,
Vivek=20
