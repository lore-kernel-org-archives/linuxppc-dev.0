Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17B10DDF87
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:26:43 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4K2QU6D009050
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 19:26:31 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4K2QTK0025847
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 21:26:30 -0500 (CDT)
MIME-Version: 1.0
Subject: RE: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
Content-Type: text/plain;
	charset="US-ASCII"
Date: Tue, 20 May 2008 10:26:28 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C1ED3@zch01exm27.fsl.freescale.net>
In-Reply-To: <1211162910.7758.2.camel@localhost>
References: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com>
	<1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
	<1211162910.7758.2.camel@localhost>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: Monday, May 19, 2008 10:09 AM
> To: Jin Zhengxiong
> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org;=20
> segher@kernel.crashing.org
> Subject: Re: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
>=20
> On Fri, 2008-05-16 at 17:50 +0800, Jason Jin wrote:
> > This MSI driver can be used on 83xx/85xx/86xx board.
> > In this driver, virtual interrupt host and chip were setup.=20
> There are=20
> > 256 MSI interrupts in this host, Every 32 MSI interrupts=20
> cascaded to=20
> > one IPIC/MPIC interrupt.
> > The chip was treated as edge sensitive and some necessary functions=20
> > were setup for this chip.
> >=20
> > Before using the MSI interrupt, PCI/PCIE device need to ask=20
> for a MSI=20
> > interrupt in the 256 MSI interrupts. A 256bit bitmap show which MSI=20
> > interrupt was used, reserve bit in the bitmap can be used=20
> to force the=20
> > device use some designate MSI interrupt in the 256 MSI interrupts.=20
> > Sometimes this is useful for testing the all the MSI=20
> interrupts. The=20
> > msi-available-ranges property in the dts file was used for this=20
> > purpose.
> >=20
> > Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> > ---
> > In the V5 version:
> > Make the msi-availble-ranges optional, remove the match=20
> function from=20
> > the driver, change the compatible according the change in dts.
>=20
> Looks good, MSI bits:
>=20
> Acked-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> cheers

Thanks, Michael.

Kumar, Could you please apply the MSI related patches. Thanks

Jason=20
