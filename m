Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id ADEFB2BD6A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 00:46:23 +1000 (EST)
Date: Fri, 17 Sep 2004 07:46:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hollis Blanchard <hollis@penguinppc.org>
Message-ID: <20040917144614.GF23760@smtp.west.cox.net>
References: <20040916182531.GA20649@george.solinno.co.uk>
	<EF4D4AFC-0815-11D9-81F8-000A95A0560C@penguinppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EF4D4AFC-0815-11D9-81F8-000A95A0560C@penguinppc.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PReP][PATCH] Fix ISA PIC interrupt acknowledge address
	detection
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2004 at 02:23:48PM -0500, Hollis Blanchard wrote:

> On Sep 16, 2004, at 1:25 PM, Leigh Brown wrote:
> 
> >The ISA PIC address for acknowledging interrupts is actually defined
> >in residual data as a 32-bit system address, rather than a 32-bit
> >memory address.  This is rather embarrasing, as I don't think this
> >function has done the right thing, ever.
> >
> >Tested and working fine on my Carolina and 140.
> 
> And this is important, as 2.6.9-rcX suffer from the dreaded Carolina 
> "lost interrupt" problems. Could we try to get this patch into 2.6.9 
> final?

I'll try and get this in quickly.

-- 
Tom Rini
http://gate.crashing.org/~trini/
