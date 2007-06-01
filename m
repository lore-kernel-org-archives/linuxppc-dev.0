Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C5BBDDEFA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 09:30:25 +1000 (EST)
Subject: Re: 2.6.22-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070601140211.81e5c301.akpm@linux-foundation.org>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<200705312243.18724.m.kozlowski@tuxland.pl>
	<20070531141943.5c4d587c.akpm@linux-foundation.org>
	<200706012250.58962.m.kozlowski@tuxland.pl>
	<20070601140211.81e5c301.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 09:30:12 +1000
Message-Id: <1180740612.19517.483.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org,
	Arnd Bergmann <arndb@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 14:02 -0700, Andrew Morton wrote:
> 
> 
> Yeah, allmodconfig tends to fall over in a heap on a lot of the
> less-lavishly-maintained architectures.  If any of these are specific
> to
> -mm then I guess we should fix them up, prevent the kernel from
> actually
> going backwards.

Some of the later seems to be related to the lack of CONFIG_PM .. it's
not much a lavish maintainership issue than the fact that nobody every
builds the powermac drivers without CONFIG_PM :-) I'll look into fixing
some of these.

As for the ps3 bits, it's a known problem, the ps3 support is still very
much a work in progress.

Cheers,
Ben.
