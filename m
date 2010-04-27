Return-Path: <wim@iguana.be>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E3618B7D45
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 17:42:38 +1000 (EST)
Date: Tue, 27 Apr 2010 09:42:29 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] booke_wdt: Fix build (unconstify watchdog_info)
Message-ID: <20100427074229.GQ15728@infomag.iguana.be>
References: <20100426174358.GA16889@oksana.dev.rtsoft.ru>
	<1272350220.24542.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272350220.24542.7.camel@pasglop>
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

Hi Ben,

> > commit 42747d712de56cf2087b702d2ad90af114c53138 ("[WATCHDOG]
> > watchdog_info constify") introduced the following build failure:
> > 
> >    CC      booke_wdt.o
> >  booke_wdt.c: In function 'booke_wdt_init':
> >  booke_wdt.c:220: error: assignment of read-only variable 'ident'
> > 
> > Fix this by removing 'const' qualifier from watchdog_info struct.
> 
> Should this go via powerpc.git ? If yes, I'll send to Linus asap.

I'm sending watchdog related patches to Linus today. This one will be included.

Kind regards,
Wim.
