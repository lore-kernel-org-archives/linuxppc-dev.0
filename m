Return-Path: <B36685@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D4BD2C020B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 21:04:37 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/2] powerpc/fsl: Update corenet64_smp_defconfig
Date: Wed, 11 Jul 2012 11:04:29 +0000
Message-ID: <3F453DDFF675A64A89321A1F3528102176E6EC@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1341916802-19619-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1341916802-19619-2-git-send-email-Shengzhou.Liu@freescale.com>
 <F985F265-DA57-47F9-AB53-4A889929BF7A@kernel.crashing.org>
In-Reply-To: <F985F265-DA57-47F9-AB53-4A889929BF7A@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Tudor Laurentiu-B10716 <B10716@freescale.com>,
 Wang Haiying-R54964 <r54964@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Rai Harninder-B01044 <B01044@freescale.com>,
 Lian Minghuan-B31939 <B31939@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, July 10, 2012 7:44 PM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Haiying-R54964; Tudor Laurentiu-B=
10716;
> Rai Harninder-B01044; Lian Minghuan-B31939
> Subject: Re: [PATCH 2/2] powerpc/fsl: Update corenet64_smp_defconfig
>=20
>=20
> On Jul 10, 2012, at 5:40 AM, Shengzhou Liu wrote:
>=20
> > * Enable USB, MMC, SATA, MTD, NAND, PAMU, RTC
> > * Enable FSL RAID on P5020
> > * Enable general RAID features (MD + async-tx)
> > * Enable RTC on P2041RDB
> > * Enable UIO SRIO & UIO DMA
> > * Enable USDPAA SHMEM driver
> > * Enable ePAPR HV support
> > * Enable PCI-E support
> >
> > Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> > Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> > Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > arch/powerpc/configs/corenet64_smp_defconfig |   94
> ++++++++++++++++++++++++--
> > 1 files changed, 89 insertions(+), 5 deletions(-)
>=20
> Is this patch really against upstream?  We dont have PAMU, UIO SRIO/DMA,e=
tc
> upstream.
>=20
> - k

Yes, it was against upstream, I posted the v2 revision w/ removing PAMU, UI=
O SRIO/DMA, etc.

Thanks,
Shengzhou
