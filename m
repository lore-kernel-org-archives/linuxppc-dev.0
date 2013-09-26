Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FDC62C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 07:11:48 +1000 (EST)
Message-ID: <1380229898.24959.318.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl/defconfig: enable CONFIG_AT803X_PHY
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Date: Thu, 26 Sep 2013 16:11:38 -0500
In-Reply-To: <3F453DDFF675A64A89321A1F35281021ADFACA@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378196906-9850-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1380158651.24959.239.camel@snotra.buserror.net>
 <3F453DDFF675A64A89321A1F35281021ADFACA@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 22:02 -0500, Liu Shengzhou-B36685 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, September 26, 2013 9:24 AM
> > To: Liu Shengzhou-B36685
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> > Subject: Re: [PATCH] powerpc/fsl/defconfig: enable CONFIG_AT803X_PHY
> > 
> > On Tue, 2013-09-03 at 16:28 +0800, Shengzhou Liu wrote:
> > > Enable CONFIG_AT803X_PHY to support AR8030/8033/8035 PHY.
> > >
> > > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > > ---
> > >  arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> > >  arch/powerpc/configs/mpc85xx_defconfig       |    1 +
> > >  arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
> > >  3 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > Why not corenet64_smp_defconfig?  Which boards have this PHY?
> > 
> > -Scott
> > 
> Currently AT803X exists on P1010RDB, P1025TWR, etc.
> It seems we don't use AT803X for those boards of corenet64.

Neither of those boards are corenet32 either.

-Scott
