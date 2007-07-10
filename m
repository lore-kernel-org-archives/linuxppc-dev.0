Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83499DDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:09:06 +1000 (EST)
In-Reply-To: <4692A5B8.9010702@freescale.com>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8CA741AA-D200-474F-943D-ECE4B3ACD38B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Tue, 10 Jul 2007 15:08:53 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I may be missing the obvious, but doesn't that defeat the purpose of
>> non-executable mappings?
>
> The hardware in question doesn't support non-executable mappings;

Not on a per-page basis, anyway.

> otherwise, it'd never have worked in the first place.  Note that  
> this is
> only allowed on 32-bit, non-book-E.
>
> There isn't much value in enforcing non-exec mappings only if it  
> happens
> to be the first fault on a given page.

Yeah.  Giving the warning is a good thing though.


Segher
