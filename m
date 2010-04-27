Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6BF0B814F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 17:45:36 +1000 (EST)
Subject: Re: [PATCH] booke_wdt: Fix build (unconstify watchdog_info)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <20100427074229.GQ15728@infomag.iguana.be>
References: <20100426174358.GA16889@oksana.dev.rtsoft.ru>
	<1272350220.24542.7.camel@pasglop>
	<20100427074229.GQ15728@infomag.iguana.be>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 17:45:24 +1000
Message-ID: <1272354324.24542.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Anton Vorontsov <avorontsov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 09:42 +0200, Wim Van Sebroeck wrote:
> Hi Ben,
> 
> > > commit 42747d712de56cf2087b702d2ad90af114c53138 ("[WATCHDOG]
> > > watchdog_info constify") introduced the following build failure:
> > > 
> > >    CC      booke_wdt.o
> > >  booke_wdt.c: In function 'booke_wdt_init':
> > >  booke_wdt.c:220: error: assignment of read-only variable 'ident'
> > > 
> > > Fix this by removing 'const' qualifier from watchdog_info struct.
> > 
> > Should this go via powerpc.git ? If yes, I'll send to Linus asap.
> 
> I'm sending watchdog related patches to Linus today. This one will be included.

Thanks !

Cheers,
Ben.
