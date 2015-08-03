Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0114.outbound.protection.outlook.com [157.56.110.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CAE1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 06:24:00 +1000 (AEST)
Message-ID: <1438633423.2097.33.camel@freescale.com>
Subject: Re: [PATCH v5] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <Yuantian.Tang@freescale.com>, <b07421@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Date: Mon, 3 Aug 2015 15:23:43 -0500
In-Reply-To: <1438600486.7515.1@remotesmtp.freescale.net>
References: <1435304656-34505-1-git-send-email-Yuantian.Tang@freescale.com>
 <1438389906.19345.101.camel@freescale.com>
 <1438600486.7515.1@remotesmtp.freescale.net>
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

On Mon, 2015-08-03 at 19:14 +0800, Chenhui Zhao wrote:
> On Sat, Aug 1, 2015 at 8:45 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Fri, 2015-06-26 at 15:44 +0800,  Yuantian.Tang@freescale.comwrote:
> > >  +static void rcpm_v1_set_ip_power(bool enable, u32 *mask)
> > >  +{
> > >  +     if (enable)
> > >  +             setbits32(&rcpm_v1_regs->ippdexpcr, *mask);
> > >  +     else
> > >  +             clrbits32(&rcpm_v1_regs->ippdexpcr, *mask);
> > >  +}
> > >  +
> > >  +static void rcpm_v2_set_ip_power(bool enable, u32 *mask)
> > >  +{
> > >  +     if (enable)
> > >  +             setbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
> > >  +     else
> > >  +             clrbits32(&rcpm_v2_regs->ippdexpcr[0], *mask);
> > >  +}
> > 
> > Why do these take "u32 *mask" instead of "u32 mask"?
> > 
> > -Scott
> 
> I think it can be used in the case where there are several mask values.

When would that be?

-Scott
