Return-Path: <Tony.Li@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62C66DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:47:43 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBE8laOv016087
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 01:47:36 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lBE8lYFw000825
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 02:47:35 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: [PATCH 2/2] powerpc: Add IPIC MSI support
Date: Fri, 14 Dec 2007 16:47:34 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635DB0633@zch01exm21.fsl.freescale.net>
In-Reply-To: <97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
References: <1196764760.2573.10.camel@Guyver>
	<97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
From: "Li Tony" <Tony.Li@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>,
	Jin Zhengxiong <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
Hi,

I think it is possible to make common code to support both IPIC and =
MPIC.
Currently, the MPIC has already implemented MSI which is different from =
IPIC and embedded into the mpic code body.
If want to unifiy MSI code, we need to remove the current MPIC MSI =
implementation.

Micheal, what is your opinion ??

Jin is working on 86xx msi now.=20

Tony


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: 2007=C4=EA12=D4=C214=C8=D5 13:45
> To: Li Tony
> Cc: Phillips Kim; michael@ellerman.id.au; linuxppc-dev
> Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
>=20
>=20
> On Dec 4, 2007, at 4:39 AM, Li Li wrote:
>=20
> > Modified based on discussion on list.
> >
> > 1. Adopt virq_to_hw routine
> > 2. Correct a legacy bug
> >
> > Implements the IPIC MSI as two level interrupt controller.
> >
> > Signed-off-by: Tony Li <tony.li@freescale.com>
>=20
> Tony, have you looked at the 85xx/86xx PCIe MSI mechanism? =20
> The 2nd level PIC handling seems like its pretty similar=20
> between IPIC and MPIC.  Would like to see if we could somehow=20
> make the code common for to handle MSIs from both?
>=20
> - k
>=20
