Return-Path: <roy.zang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4F3E2C00B7
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 09:49:33 +1100 (EST)
Received: from mail17-ch1 (localhost [127.0.0.1])	by mail17-ch1-R.bigfish.com
 (Postfix) with ESMTP id ABD3F300479	for <linuxppc-dev@ozlabs.org>;
 Tue, 12 Nov 2013 22:49:30 +0000 (UTC)
Received: from CH1EHSMHS036.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail17-ch1.bigfish.com (Postfix) with ESMTP id
 0EA2F480041
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 22:49:29 +0000 (UTC)
From: Roy Zang <roy.zang@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>
Subject: RE: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
Date: Tue, 12 Nov 2013 22:49:26 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B37812C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
 <1384293891.1403.70.camel@snotra.buserror.net>
In-Reply-To: <1384293891.1403.70.camel@snotra.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Scott Wood
> Sent: Tuesday, November 12, 2013 4:05 PM
> To: Pan Lijun-B44306
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
> mpc85xx_smp_defconfig and mpc85xx_defconfig
>=20
> On Mon, 2013-11-11 at 13:25 -0600, Lijun Pan wrote:
> > mpc85xx_smp_defconfig and mpc85xx_defconfig already have
> CONFIG_P1023RDS=3Dy.
> > Merge CONFIG_P1023RDB=3Dy and other relevant configurations into
> mpc85xx_smp_defconfig and mpc85_defconfig.
> >
> > Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> > ---
> >  arch/powerpc/configs/85xx/p1023_defconfig  |  188 --------------------
> --------
> >  arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
> >  arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
> >  3 files changed, 35 insertions(+), 188 deletions(-)  delete mode
> > 100644 arch/powerpc/configs/85xx/p1023_defconfig
>=20
> Are we still going to want to have one defconfig if and when we finally
> get datapath support upstream?  That's a lot of code to add to the 85xx
> config just for this one chip.
P1023 has dpaa.
Will mpc85xx_defconfig or mpc85xx_smp_defconfig support dpaa?
Thanks.
Roy
