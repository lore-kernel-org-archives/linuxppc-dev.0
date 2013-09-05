Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CC072C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 14:00:17 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [V2,2/2] powerpc/85xx: workaround for chips with MSI hardware
 errata
Date: Thu, 5 Sep 2013 04:00:08 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01D40DC2@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
 <20130628022833.GA28050@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Monday, July 01, 2013 5:36 PM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> Subject: RE: [V2,2/2] powerpc/85xx: workaround for chips with MSI
> hardware errata
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, June 28, 2013 10:29 AM
> > To: Jia Hongtao-B38951
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood
> > Scott-
> > B07421
> > Subject: Re: [V2,2/2] powerpc/85xx: workaround for chips with MSI
> > hardware errata
> >
> > On Wed, Apr 03, 2013 at 10:03:18AM +0800, Hongtao Jia wrote:
> > > The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It
> > > causes that neither MSI nor MSI-X can work fine. This is a
> > > workaround to allow MSI-X to function properly.
> > >
> > > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> >
> > Building on 83xx:
> >
> >   arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
> >   fsl_msi.c:(.text+0x1464): undefined reference to
> > `fsl_mpic_primary_get_version'
> >   make[1]: *** [vmlinux] Error 1
> >   make: *** [sub-make] Error 2
> >
> > fsl_msi.c supports IPIC as well.
> >
> > -Scott
>=20
> Hi Scott,
> I updated the patch to fix this compile error just now.
> please refer to:
> http://patchwork.ozlabs.org/patch/256018/
>=20
> Thanks.
> -Hongtao

Hi Scott,

The 83xx compile issue has already been fixed.
Please have a review on this patch.

Thanks.
-Hongtao
