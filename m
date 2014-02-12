Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 820E42C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 20:39:50 +1100 (EST)
Message-ID: <1392197977.3835.124.camel@pasglop>
Subject: Re: [PATCH] powerpc: set the correct ksp_limit on ppc32 when
 switching to irq stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 12 Feb 2014 20:39:37 +1100
In-Reply-To: <20140212055151.GB15434@pek-khao-d1.corp.ad.wrs.com>
References: <1389932728-25178-1-git-send-email-haokexin@gmail.com>
 <20140121161450.GA3311@roeck-us.net> <1390340928.9227.13.camel@pasglop>
 <20140212055151.GB15434@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-02-12 at 13:51 +0800, Kevin Hao wrote:
> On Wed, Jan 22, 2014 at 08:48:48AM +1100, Benjamin Herrenschmidt wrote:
> > It will be merged when I come back from vacation. It was too late for
> > 3.13 so I'll send it to Linus next week and will CC -stable.
> 
> Hi Ben,
> 
> Any reason why this is still not merged yet?

No other than for some reason I missed it in patchwork when I did my
shopping from it yesterday.

I've added it to a bundle so I won't forget on my next round.

Cheers,
Ben.
