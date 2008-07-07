Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B749DDE00
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 11:15:27 +1000 (EST)
Subject: Re: the printk problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<1215212420.8970.8.camel@pasglop>
	<alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Date: Mon, 07 Jul 2008 11:14:36 +1000
Message-Id: <1215393276.8970.36.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, parisc-linux@parisc-linux.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-04 at 16:25 -0700, Linus Torvalds wrote:
> 
> On Sat, 5 Jul 2008, Benjamin Herrenschmidt wrote:
> > 
> > I'll give it a try using ﻿probe_kernel_address() instead on monday.
> 
> Here's the updated patch which uses probe_kernel_address() instead (and 
> moves the whole #ifdef mess out of the code that wants it and into a 
> helper function - and maybe we should then put that helper into 
> kallsyms.h, but that's a different issue).
> 
> Still all happily untested, of course. And still with no actual users 
> converted.

Did a few tests and it seems to work. I'll stick a patch converting
powerpc to use %pS for oops display in -next.

Thanks !

Cheers,
Ben.
