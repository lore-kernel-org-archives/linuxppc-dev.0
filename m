Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E81FFDDD05
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:41:08 +1000 (EST)
In-Reply-To: <20070601140211.81e5c301.akpm@linux-foundation.org>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<200705312243.18724.m.kozlowski@tuxland.pl>
	<20070531141943.5c4d587c.akpm@linux-foundation.org>
	<200706012250.58962.m.kozlowski@tuxland.pl>
	<20070601140211.81e5c301.akpm@linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7fa6c0b6701499b0c6cf5aae2a261dc1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.22-rc3-mm1
Date: Sat, 2 Jun 2007 10:40:59 +0200
To: Andrew Morton <akpm@linux-foundation.org>
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

> Yeah, allmodconfig tends to fall over in a heap on a lot of the
> less-lavishly-maintained architectures.

To be fair, almost all of the powerpc allmodconfig build
problems are caused by x86-only drivers (and most of those
I doubt still work on x86, even).


Segher
