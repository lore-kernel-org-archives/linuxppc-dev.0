Return-Path: <scottwood@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB6402C00B7
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 10:09:39 +1100 (EST)
Received: from mail177-db9 (localhost [127.0.0.1])	by
 mail177-db9-R.bigfish.com (Postfix) with ESMTP id 044F14408AC	for
 <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 23:09:36 +0000 (UTC)
Received: from DB9EHSMHS003.bigfish.com (unknown [10.174.16.249])	by
 mail177-db9.bigfish.com (Postfix) with ESMTP id EB7DF4023B	for
 <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 23:09:33 +0000 (UTC)
Message-ID: <1384297770.1403.78.camel@snotra.buserror.net>
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
From: Scott Wood <scottwood@freescale.com>
To: Zang Roy-R61911 <roy.zang@freescale.com>
Date: Tue, 12 Nov 2013 17:09:30 -0600
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B37817C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
 <1384293891.1403.70.camel@snotra.buserror.net>
 <3E027F8168735B46AC006B1D0C7BB0020B37812C@039-SN2MPN1-011.039d.mgd.msft.net>
 <1384296734.1403.72.camel@snotra.buserror.net>
 <3E027F8168735B46AC006B1D0C7BB0020B37817C@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Pan Lijun-B44306 <Lijun.Pan@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-12 at 17:05 -0600, Zang Roy-R61911 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, November 12, 2013 4:52 PM
> > To: Zang Roy-R61911
> > Cc: Pan Lijun-B44306; linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
> > mpc85xx_smp_defconfig and mpc85xx_defconfig
> > 
> > On Tue, 2013-11-12 at 16:49 -0600, Zang Roy-R61911 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> > > > fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Scott Wood
> > > > Sent: Tuesday, November 12, 2013 4:05 PM
> > > > To: Pan Lijun-B44306
> > > > Cc: linuxppc-dev@ozlabs.org
> > > > Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig
> > > > into mpc85xx_smp_defconfig and mpc85xx_defconfig
> > > >
> > > > On Mon, 2013-11-11 at 13:25 -0600, Lijun Pan wrote:
> > > > > mpc85xx_smp_defconfig and mpc85xx_defconfig already have
> > > > CONFIG_P1023RDS=y.
> > > > > Merge CONFIG_P1023RDB=y and other relevant configurations into
> > > > mpc85xx_smp_defconfig and mpc85_defconfig.
> > > > >
> > > > > Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> > > > > ---
> > > > >  arch/powerpc/configs/85xx/p1023_defconfig  |  188
> > > > > --------------------
> > > > --------
> > > > >  arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
> > > > >  arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
> > > > >  3 files changed, 35 insertions(+), 188 deletions(-)  delete mode
> > > > > 100644 arch/powerpc/configs/85xx/p1023_defconfig
> > > >
> > > > Are we still going to want to have one defconfig if and when we
> > > > finally get datapath support upstream?  That's a lot of code to add
> > > > to the 85xx config just for this one chip.
> > > P1023 has dpaa.
> > > Will mpc85xx_defconfig or mpc85xx_smp_defconfig support dpaa?
> > 
> > That's the question I'm asking.  Though I suppose we could take a patch
> > like this one for now, and then introduce mpc85xx_dpaa_defconfig when it
> > becomes relevant (which would make clear why the defconfig is separate).
> > p1023 would still work with the non-dpaa defconfigs, but without dpaa
> > support.
> 
> It will be hard to find a seat for P1023 in mpc85xx_dpaa_defconfig.

What do you mean?

> P1023 does not have corenet.  It has e500v2 core.
> All the  other DPAA SOCs have corenet.
> I suggest  leaving p1023 defconfig standalone.

I didn't say "mpc85xx_corenet_defconfig", nor did I suggest that
mpc85xx_dpaa_defconfig replace corenet32_defconfig.  Perhaps
e500v2_dpaa_defconfig would be a better name.  It would effectively be a
standalone p1023 defconfig, but with a name that reflects the reason for
it, and which would accommodate future e500v2 dpaa chips in the unlikely
case that such things are made.

Do you know how large the current SDK datapath code is?  Though perhaps
the eventual upstream version will be smaller.

-Scott
