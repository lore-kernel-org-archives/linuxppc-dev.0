Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 90BA067B58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Jun 2005 02:58:44 +1000 (EST)
Date: Fri, 24 Jun 2005 09:58:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Message-ID: <20050624165841.GD3628@smtp.west.cox.net>
References: <42BAD78E.1020801@ru.mvista.com>
	<20050623140522.GA25724@logos.cnet>
	<42BC2501.5090101@ru.mvista.com>
	<20050624154311.GB3628@smtp.west.cox.net>
	<42BC34CE.603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42BC34CE.603@ru.mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, yshpilevsky@ru.mvista.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: add Freescale MPC885ADS board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 24, 2005 at 08:29:02PM +0400, Andrei Konovalov wrote:
> Tom Rini wrote:
[snip]
> >Lets just drop that hunk then..
> 
> Do you mean not to use
>   io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);

So I had myself slightly confused as first, but yes, what Eugene said at
first is right, as shouldn't add more io_block_mappings, we should use
ioremap() and fix drivers.

-- 
Tom Rini
http://gate.crashing.org/~trini/
