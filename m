Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACFA967B7F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 17:33:49 +1000 (EST)
Subject: Re: SMP in 32-bit arch/powerpc
From: Adrian Cox <adrian@humboldt.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1155769968.11312.110.camel@localhost.localdomain>
References: <1154507145.24203.0.camel@localhost.localdomain>
	<E1G8HvV-0007o7-0C@jdl.com>
	<1155769968.11312.110.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 08:19:04 +0100
Message-Id: <1155799144.28319.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 01:12 +0200, Benjamin Herrenschmidt wrote:
> For completeness, there is a known bug with 32 bits and SMP regarding
> icache coherency.... If you have random SIGILL/SEGV under load, that's
> probably what you are hitting. The problem is due to the way we do the
> coherency and isn't trivial to fix unfortunately, though it's also
> fairly rare.

Could you give a few more details?  I'd not heard of the problem before,
and I couldn't find any references with a few quick searches. I've not
seen the problem myself, but I've not run any heavy page fault loads,
only Altivec load.

-- 
Adrian Cox <adrian@humboldt.co.uk>
