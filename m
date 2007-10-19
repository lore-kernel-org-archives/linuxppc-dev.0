Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85F15DDEA3
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 20:45:02 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9JAiuS9015018
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 03:44:57 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9JAitU6018116
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:44:56 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] qe_lib: export symbols to fix compile error when QE
	drivers compile as modules
Date: Fri, 19 Oct 2007 18:44:53 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5C9B@zch01exm26.fsl.freescale.net>
In-Reply-To: <F2C6FCFC-78EF-4660-85F8-10C1AFE860F4@kernel.crashing.org>
References: <989B956029373F45A0B8AF0297081890B768A2@zch01exm26.fsl.freescale.net>
	<24BADA7A-1716-43B1-BC92-F4DB7ED0D331@kernel.crashing.org>
	<F2C6FCFC-78EF-4660-85F8-10C1AFE860F4@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, October 17, 2007 11:30 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev list; Tabi Timur-B04825
> Subject: Re: [PATCH] qe_lib: export symbols to fix compile=20
> error when QE drivers compile as modules
>=20
>=20
> On May 25, 2007, at 7:15 AM, Kumar Gala wrote:
>=20
> >
> > On May 24, 2007, at 9:45 PM, Li Yang-r58472 wrote:
> >
> >>
> >>> -----Original Message-----
> >>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >>> Sent: Thursday, May 24, 2007 7:44 PM
> >>> To: Li Yang-r58472
> >>> Cc: Paul; linuxppc-dev@ozlabs.org
> >>> Subject: Re: [PATCH] qe_lib: export symbols to fix compile error=20
> >>> when
> >> QE drivers
> >>> compile as modules
> >>>
> >>>
> >>> On May 24, 2007, at 4:14 AM, Li Yang wrote:
> >>>
> >>>> Export symbols of qe_lib to be used by QE drivers.
> >>>>
> >>>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>>> ---
> >>>> arch/powerpc/sysdev/qe_lib/ucc.c      |    7 +++++++
> >>>> arch/powerpc/sysdev/qe_lib/ucc_fast.c |    8 ++++++++
> >>>> arch/powerpc/sysdev/qe_lib/ucc_slow.c |   12 ++++++++++--
> >>>> 3 files changed, 25 insertions(+), 2 deletions(-)
> >>>
>=20
> What happened with this?

This has been merged as commit 65482ccf9d00bf4f68e17eb9c656d045d26e5d1f.

- Leo
