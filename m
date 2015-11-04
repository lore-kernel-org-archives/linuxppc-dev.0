Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0134.outbound.protection.outlook.com [157.56.111.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0DE31A0B78
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 09:45:36 +1100 (AEDT)
Message-ID: <1446677115.12676.26.camel@freescale.com>
Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management support
From: Scott Wood <scottwood@freescale.com>
To: Eduardo Valentin <edubezval@gmail.com>
CC: Hongtao Jia <hongtao.jia@freescale.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 4 Nov 2015 16:45:15 -0600
In-Reply-To: <20151104192444.GA14127@localhost.localdomain>
References: <1442996938-47147-1-git-send-email-hongtao.jia@freescale.com>
 <1443132592.32298.56.camel@freescale.com>
 <BLUPR03MB14997B46CC6AFC247EDC340E1420@BLUPR03MB149.namprd03.prod.outlook.com>
 <20151104192444.GA14127@localhost.localdomain>
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

On Wed, 2015-11-04 at 11:24 -0800, Eduardo Valentin wrote:
> On Fri, Sep 25, 2015 at 03:09:42AM +0000, Hongtao Jia wrote:
> > 
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, September 25, 2015 6:10 AM
> > > To: Jia Hongtao-B38951
> > > Cc: edubezval@gmail.com; linux-pm@vger.kernel.org; linuxppc-
> > > dev@lists.ozlabs.org
> > > Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management support
> > > 
> > > On Wed, 2015-09-23 at 16:28 +0800, Jia Hongtao wrote:
> > > > This driver add thermal management support by enabling TMU (Thermal
> > > > Monitoring Unit) on QorIQ platform.
> > > > 
> > > > It's based on thermal of framework:
> > > > - Trip points defined in device tree.
> > > > - Cpufreq as cooling device registered in qoriq cpufreq driver.
> > > 
> > > I don't see any cooling device registered in the qoriq cpufreq driver.
> > > Is this dependent on some other patch?
> > 
> > It's not depend on any patch. But I saw your patch below:
> > [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation details
> > So I hold my patch waiting for your patch merged or there will be 
> > conflict.
> > 
> > I could send it out too if you are fine with it.
> 
> Would you guys benefit of cpufreq-cpu0?

If you mean cpufreq-dt, no, as I explained in 
https://lkml.org/lkml/2015/9/18/699

-Scott
