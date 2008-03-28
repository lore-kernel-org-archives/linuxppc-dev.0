Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EA69DDF40
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:10:35 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2S2ASkj003336
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 19:10:29 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2S2AQT4004259
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 21:10:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] fsldma: The MPC8377MDS board device tree node for fsldma
	driver
Date: Fri, 28 Mar 2008 10:10:23 +0800
Message-ID: <78567AC4946EDC42B7DE978C350CD869EC5A06@zch01exm26.fsl.freescale.net>
In-Reply-To: <e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
References: <1206517356-11209-1-git-send-email-wei.zhang@freescale.com>
	<1206517356-11209-2-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Dan Williams" <dan.j.williams@intel.com>,
	"Andrew Morton" <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Dan,

Sure. The patch can be just a reference to how to config and enable the =
fsldma driver in dts file on MPC83xx boards.

Thanks!
Wei.

> -----Original Message-----
> From: dan.j.williams@gmail.com=20
> [mailto:dan.j.williams@gmail.com] On Behalf Of Dan Williams
> Sent: Friday, March 28, 2008 3:38 AM
> To: Zhang Wei; Andrew Morton
> Cc: Linux Kernel; Kumar Gala; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] fsldma: The MPC8377MDS board device tree=20
> node for fsldma driver
>=20
> On Wed, Mar 26, 2008 at 12:42 AM, Zhang Wei=20
> <wei.zhang@freescale.com> wrote:
> > The fsldma driver is tested on MPC8377MDS board.
> >  The patch adds fsldma driver support into MPC8377MDS device tree.
> >
> >  Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> >  ---
> >   arch/powerpc/boot/dts/mpc8377_mds.dts |   27=20
> +++++++++++++++++++++++++++
> >   1 files changed, 27 insertions(+), 0 deletions(-)
>=20
> I think this patch should probably go through the powerpc tree, or
> -mm.  I'll pick up the ones that touch either drivers/dma or
> crypto/async_tx.
>=20
> --
> Dan
>=20
