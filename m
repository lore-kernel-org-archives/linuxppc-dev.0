Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36BDADDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 17:13:59 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1J6Ds7E011239
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 23:13:55 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1J6DrR1008199
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 00:13:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC v1] virtio: add virtio-over-PCI driver
Date: Thu, 19 Feb 2009 14:13:54 +0800
Message-ID: <7DF0AF56456B8F4081E3C44CCCE311DE1519A3@zch01exm23.fsl.freescale.net>
In-Reply-To: <D999D051-E5A2-4915-893D-E3384EC312A4@kernel.crashing.org>
References: <20090217222425.GA18801@ovro.caltech.edu>
	<D999D051-E5A2-4915-893D-E3384EC312A4@kernel.crashing.org>
From: "Zang Roy-R61911" <tie-fei.zang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Ira Snyder" <iws@ovro.caltech.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@ozlabs
> .org] On Behalf Of Kumar Gala
> Sent: Thursday, February 19, 2009 0:47 AM
> To: Ira Snyder
> Cc: Arnd Bergmann; Jan-Bernd Themann; netdev@vger.kernel.org;=20
> Rusty Russell; linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [RFC v1] virtio: add virtio-over-PCI driver
>=20
>=20
> On Feb 17, 2009, at 4:24 PM, Ira Snyder wrote:
>=20
> >
> > Documentation/virtio-over-PCI.txt     |   61 ++
> > arch/powerpc/boot/dts/mpc834x_mds.dts |    7 +
>=20
> we'll have to review the .dts and expect a documentation update for =20
> the node.  But that's pretty minor at this point.
>=20
> > drivers/virtio/Kconfig                |   22 +
> > drivers/virtio/Makefile               |    2 +
> > drivers/virtio/vop.h                  |  119 ++
> > drivers/virtio/vop_fsl.c              | 1911=20
> ++++++++++++++++++++++++=20
> > +++++++++
>=20
> make this vop_fsl_mpc83xx.c or something along those lines.
why?
Roy
