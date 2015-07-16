Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A6CB1A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 06:31:10 +1000 (AEST)
Message-ID: <1437078653.2993.121.camel@freescale.com>
Subject: Re: powerpc/corenet: enable eSDHC
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Date: Thu, 16 Jul 2015 15:30:53 -0500
In-Reply-To: <BY1PR0301MB1192803896118A14B8A2ABF3F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
 <20150530000331.GA9143@home.buserror.net>
 <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1433795433.2477.62.camel@freescale.com>
 <BY1PR0301MB1192803896118A14B8A2ABF3F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
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

OK, thanks.  Assuming no similar issues when testing, I'll apply this patch 
the next time I do a batch of patch application.

Any thoughts regarding better error handling?

-Scott

On Wed, 2015-07-15 at 21:37 -0500, Lu Yangbo-B47093 wrote:
> Hi Scott,
> 
> Now the patch below has been merged on 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git.
> This issue should have been resolved. 
> Thanks.
> 
> 
> commit 5fd26c7ecb32082745b0bd33c8e35badd1cb5a91
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Fri Jun 5 11:40:08 2015 +0200
> 
>     mmc: sdhci: Restore behavior while creating OCR mask
> 
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, June 09, 2015 4:31 AM
> > To: Lu Yangbo-B47093
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-mmc@vger.kernel.org
> > Subject: Re: powerpc/corenet: enable eSDHC
> > 
> > On Mon, 2015-06-08 at 05:12 -0500, Lu Yangbo-B47093 wrote:
> > > Thanks a lot, Scott.
> > > And now a patch was merged on
> > > git://git.linaro.org/people/ulf.hansson/mmc.git next branch to fix
> > > this issue.
> > > It should be no problem.
> > 
> > Assuming that patch fixes it and gets pulled for 4.2, this config patch
> > can go in for 4.3.
> > 
> > That said, it would be nice if, apart from fixing the problem itself, the
> > MMC code failed more gracefully instead of endlessly repeating and
> > filling up the log/console.
> > 
> > -Scott
> 
