Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1756D1A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 13:10:44 +1000 (AEST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [1/2] powerpc/config: enable teranetics PHY
Date: Wed, 5 Aug 2015 03:10:37 +0000
Message-ID: <BLUPR03MB14755E5AE4FAEF4783BBA1DDE2750@BLUPR03MB1475.namprd03.prod.outlook.com>
References: <1437709533-26452-1-git-send-email-shh.xie@gmail.com>
 <20150805001848.GA2861@home.buserror.net>
In-Reply-To: <20150805001848.GA2861@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, August 05, 2015 8:19 AM
> To: shaohui xie
> Cc: linuxppc-dev@lists.ozlabs.org; Xie Shaohui-B21989
> Subject: Re: [1/2] powerpc/config: enable teranetics PHY
>=20
> On Fri, Jul 24, 2015 at 11:45:33AM +0800, shaohui xie wrote:
> > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> >
> > The PHY uses XAUI interface to connect to MAC, mostly the PHY used on
> > riser card.
> >
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > ---
> >  arch/powerpc/configs/corenet32_smp_defconfig | 1 +
> > arch/powerpc/configs/corenet64_smp_defconfig | 1 +
> >  2 files changed, 2 insertions(+)
>=20
> Next time, please use a subject line that lets me know that this is a
> patch that I'd be picking up, such as "powerpc/85xx: ..." or
> "powerpc/corenet: ..."
OK.
Sorry for the inconvenience.

Thanks.
Shaohui
