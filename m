Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0145.outbound.protection.outlook.com [157.56.110.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 902991A035C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 06:30:47 +1000 (AEST)
Message-ID: <1433795433.2477.62.camel@freescale.com>
Subject: Re: powerpc/corenet: enable eSDHC
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Date: Mon, 8 Jun 2015 15:30:33 -0500
In-Reply-To: <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
 <20150530000331.GA9143@home.buserror.net>
 <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
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

On Mon, 2015-06-08 at 05:12 -0500, Lu Yangbo-B47093 wrote:
> Thanks a lot, Scott.
> And now a patch was merged on 
> git://git.linaro.org/people/ulf.hansson/mmc.git next branch to fix 
> this issue.
> It should be no problem.

Assuming that patch fixes it and gets pulled for 4.2, this config 
patch can go in for 4.3.

That said, it would be nice if, apart from fixing the problem itself, 
the MMC code failed more gracefully instead of endlessly repeating and 
filling up the log/console.

-Scott
