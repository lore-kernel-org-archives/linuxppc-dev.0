Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 9C6E567A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 09:14:08 +1100 (EST)
Date: Wed, 16 Mar 2005 15:14:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050316221402.GA8345@smtp.west.cox.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110915063.5937.93.camel@ad.doubleclick.net>
	<583185c11becaca3ce73e4010c18154d@freescale.com>
	<1110925103.5937.107.camel@ad.doubleclick.net>
	<dfbb0a3397338a3abfc2f93450311b9b@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dfbb0a3397338a3abfc2f93450311b9b@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 16, 2005 at 01:22:48AM -0600, Kumar Gala wrote:

> Jason,
> 
> Is it possible to make this against a newer tree (like a current bk 
> pull).  The patch doesn't apply cleanly against head.S, which I'm 
> guessing is due to the SPRN changes pushed upstream recently.
> 
> If I can apply it cleanly, I will get it pushed upstream.

Can one of you run say LTP on a classic box, just as a sanity test
before pushing?  If not, lemme know and I'll do it :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
