Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0132.outbound.protection.outlook.com [207.46.100.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F9BE1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 14:10:45 +1000 (AEST)
Message-ID: <1438747830.2097.106.camel@freescale.com>
Subject: Re: [1/2] powerpc/config: enable teranetics PHY
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 4 Aug 2015 23:10:30 -0500
In-Reply-To: <BLUPR03MB14750DBFAA5B7BD0FE1974EDE2750@BLUPR03MB1475.namprd03.prod.outlook.com>
References: <1437709533-26452-1-git-send-email-shh.xie@gmail.com>
 <20150805001848.GA2861@home.buserror.net>
 <1438734294.2097.102.camel@freescale.com>
 <1438734404.2097.104.camel@freescale.com>
 <BLUPR03MB14750DBFAA5B7BD0FE1974EDE2750@BLUPR03MB1475.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-04 at 22:06 -0500, Xie Shaohui-B21989 wrote:
> > -----Original Message-----
> > From: Xie Shaohui-B21989
> > Sent: Wednesday, August 05, 2015 11:00 AM
> > To: Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: RE: [1/2] powerpc/config: enable teranetics PHY
> > 
> > > On Tue, 2015-08-04 at 19:24 -0500, Scott Wood wrote:
> > > > On Tue, 2015-08-04 at 19:18 -0500, Scott Wood wrote:
> > > > > On Fri, Jul 24, 2015 at 11:45:33AM +0800, shaohui xie wrote:
> > > > > > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> > > > > > 
> > > > > > The PHY uses XAUI interface to connect to MAC, mostly the PHY
> > > > > > used on riser card.
> > > > > > 
> > > > > > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > > > > > ---
> > > > > >  arch/powerpc/configs/corenet32_smp_defconfig | 1 +
> > > > > > arch/powerpc/configs/corenet64_smp_defconfig | 1 +
> > > > > >  2 files changed, 2 insertions(+)
> > > > > 
> > > > > Next time, please use a subject line that lets me know that this
> > > > > is a patch that I'd be picking up, such as "powerpc/85xx: ..." or
> > > > > "powerpc/corenet: ..."
> > > > 
> > > > More importantly, don't send patches to enable config options that
> > > > don't exist.
> > > 
> > > Sorry, this comment was meant for patch 2/2 (CONFIG_AQUANTIA_PHY).
> > > CONFIG_TERANETICS_PHY does exist in linux-next (that it depends on a
> > > patch in linux-next should be mentioned below the ---).
> > Hi Scott,
> > 
> > The CONFIG_AQUANTIA_PHY was added in another patch sent to net-next, it
> > was not accepted when I sent the patch to enable this config, later the
> > patch was accepted in net-next,
> > https://git.kernel.org/cgit/linux/kernel/git/davem/net-
> > next.git/commit/?id=bee8259dd31f419a883174556b11edc6f9a153d1
> [S.H] Just found the patch was also merged in Linux-next:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=bee8259dd31f419a883174556b11edc6f9a153d1

OK, thanks for letting me know.  I must have been looking at a linux-next 
that I fetched before that.  No need to resend, just next time let me know 
about the dependency.

-Scott
