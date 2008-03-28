Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0DD2DDF93
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:26:09 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2S2Q3n6009550
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 19:26:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2S2PxRL005244
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 21:26:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] fsldma: The MPC8377MDS board device tree node for fsldma
	driver
Date: Fri, 28 Mar 2008 10:25:56 +0800
Message-ID: <78567AC4946EDC42B7DE978C350CD869EC5A1C@zch01exm26.fsl.freescale.net>
In-Reply-To: <9D668111-9774-4D45-944E-3C3C0EE47A09@kernel.crashing.org>
References: <1206517356-11209-1-git-send-email-wei.zhang@freescale.com>
	<1206517356-11209-2-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
	<9D668111-9774-4D45-944E-3C3C0EE47A09@kernel.crashing.org>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Dan Williams" <dan.j.williams@intel.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'll send it to to.=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, March 28, 2008 10:24 AM
> To: Dan Williams
> Cc: Zhang Wei; Andrew Morton; Linux Kernel; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] fsldma: The MPC8377MDS board device tree=20
> node for fsldma driver
>=20
>=20
> On Mar 27, 2008, at 2:37 PM, Dan Williams wrote:
> > On Wed, Mar 26, 2008 at 12:42 AM, Zhang Wei =20
> > <wei.zhang@freescale.com> wrote:
> >> The fsldma driver is tested on MPC8377MDS board.
> >> The patch adds fsldma driver support into MPC8377MDS device tree.
> >>
> >> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> >> ---
> >>  arch/powerpc/boot/dts/mpc8377_mds.dts |   27=20
> ++++++++++++++++++++++=20
> >> +++++
> >>  1 files changed, 27 insertions(+), 0 deletions(-)
> >
> > I think this patch should probably go through the powerpc tree, or
> > -mm.  I'll pick up the ones that touch either drivers/dma or
> > crypto/async_tx.
>=20
> Can you resend and CC me.  I'll pick it up and push through via the =20
> powerpc tree.
>=20
> I want to make one update to the driver to support the=20
> "proper" names =20
> we document for compatible properties.
>=20
> (uugh too many things to do)
>=20
> - k
>=20
