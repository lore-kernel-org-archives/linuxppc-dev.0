Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4331CDED75
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 06:27:35 +1100 (EST)
Date: Mon, 13 Oct 2008 21:27:29 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <20081013184443.GA20612@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0810132119510.9041@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Cc: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Oct 2008, Scott Wood wrote:

> On Mon, Oct 13, 2008 at 08:05:09PM +0200, Guennadi Liakhovetski wrote:
> > On Mon, 13 Oct 2008, Rog=E9rio Brito wrote:
> >=20
> > > The current defconfig for Linkstation/Kuroboxes has the "Disable Heap
> > > Randomization" option enabled.
> > >=20
> > > Since some of these machines are facing the internet, it helps to hav=
e
> > > heap randomization enabled. This patch enables it.
> >=20
> > Same as the previous patch - this is one of options, that users select=
=20
> > according to their needs. If any specific distribution enables this opt=
ion=20
> > by default in their kernels, they can do this too, don't think this is=
=20
> > critical enough to patch the defconfig.
>=20
> Just because users/distros can change it doesn't mean it's pointless to
> discuss what default is sane, and make changes if the current default
> isn't.
>=20
> For security-related options it's usually best to default to the more
> secure state, especially since the option description talks about it
> being needed mainly for libc5 compatibility -- did libc5 ever even exist
> for powerpc? =20

In a 2.6.27-rc5-ish snapshot I counted 68 enabled and 11 disabled=20
CONFIG_COMPAT_BRK under arch/powerpc/configs/. Ok, enabling it for all=20
would be a bit rude, and one has to start somewhere...

> The only reason it was turned on in the first place was likely the
> "default y", which in turn is there to avoid breaking old x86 distros.

Then maybe it would be better to make default y only for some platforms?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
