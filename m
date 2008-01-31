Return-Path: <Wei.Zhang@FREESCALE.COM>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15A2CDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 17:39:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m0V6bQQZ024934
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 23:39:38 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0V64Nmc015246
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 00:04:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/6] Change RIO function mpc85xx_ to fsl_ .
Date: Thu, 31 Jan 2008 14:04:22 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD0683@zch01exm26.fsl.freescale.net>
In-Reply-To: <A3EAB036-F69D-48DD-8CA9-4EAAE63AE1F5@kernel.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<A3EAB036-F69D-48DD-8CA9-4EAAE63AE1F5@kernel.crashing.org>
From: "Zhang Wei" <Wei.Zhang@FREESCALE.COM>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All right, I'll give you another patch for 86xx dts file. :)

 Btw: Why the PCI and other nodes were moved from SOC? Just for clear?
If they are moved out, their register address must use full address not
offset address.

Thanks!
Wei.

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, January 30, 2008 10:44 PM
> To: Zhang Wei
> Cc: mporter@kernel.crashing.org;=20
> linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/6] Change RIO function mpc85xx_ to fsl_ .
>=20
> Can you post a device tree update as well.
>=20
> The older patches on the list for the 86xx .dts should NOT=20
> put the rio =20
> node under the soc.  It should be at the same level as PCI.
>=20
> - k
>=20
