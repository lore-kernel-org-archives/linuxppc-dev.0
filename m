Return-Path: <SRS0+b1a8919817a61a648e9e+1226+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EB14DDE2C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 07:55:51 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: David Woodhouse <dwmw2@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b3e2d9d05daea206820fc34181c93975@kernel.crashing.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<b3e2d9d05daea206820fc34181c93975@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 20:56:06 +0000
Message-Id: <1167684966.18169.1.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-01 at 21:42 +0100, Segher Boessenkool wrote:
> > On the Maple board, the AMD8111 IDE is in legacy mode... except that it
> > appears on IRQ 20 instead of IRQ 15.
> 
> How does this work?  The hardware routes the EIDE interrupts
> to #14/#15 in legacy mode, just like it should.  Can you show
> the relevant configuration bits please? 

Gladly, if you tell me where to look -- what controls IRQ routing?

Or just give me a SSH public key and poke at it yourself.

-- 
dwmw2
