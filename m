Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 162F61A0743
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 01:09:58 +1000 (AEST)
Message-ID: <1437750584.2993.227.camel@freescale.com>
Subject: Re: powerpc/corenet: enable eSDHC
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Date: Fri, 24 Jul 2015 10:09:44 -0500
In-Reply-To: <BY1PR0301MB119285C61D7CDC037DD240DAF2850@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
 <20150530000331.GA9143@home.buserror.net>
 <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1433795433.2477.62.camel@freescale.com>
 <BY1PR0301MB1192803896118A14B8A2ABF3F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1437078653.2993.121.camel@freescale.com>
 <BY1PR0301MB119285C61D7CDC037DD240DAF2850@BY1PR0301MB1192.namprd03.prod.outlook.com>
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

On Mon, 2015-07-20 at 01:43 -0500, Lu Yangbo-B47093 wrote:
> > OK, thanks.  Assuming no similar issues when testing, I'll apply this
> > patch the next time I do a batch of patch application.
> > 
> > Any thoughts regarding better error handling?
> > 
> > -Scott
> 
> Do you mean SD test?

I just mean that I will verify that enabling the option doesn't make things 
worse.

> Actually SD patches needing to sent to upstream are tested on Li Yang's 
> Linux tree.

I thought you said the patch was already merged.

> And the JIRA ticket is QORIQLU-19.

Don't reference internal tickets on upstream lists.

-Scott
