Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 9C7922BF0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 06:43:01 +1100 (EST)
Date: Thu, 4 Nov 2004 12:42:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Message-ID: <20041104194259.GI13456@smtp.west.cox.net>
References: <1092926140.10314.101.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092926140.10314.101.camel@localhost>
Cc: mcclintock@freescale.com, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] Test patch for Sandpoint X2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 19, 2004 at 03:35:40PM +0100, Adrian Cox wrote:

> The attached patch puts support for Sandpoint X2 back into Linux 2.6.
> Unlike my previous attempts, this patch detects the Sandpoint model at
> runtime. I only have an X2 here, so I would appreciate reports of the
> code being unbroken on the X3.
> 
> The patch causes EPIC_SERIAL_MODE to be a runtime rather than compile
> time decision. It also changes the UART interrupts from level to edge,
> which on my X2 is required in order to work with the serial driver in
> 2.6. I'd also like to know if this breaks the X3.

Sorry for the horrific delay.  I've tested this on my X3, and it works.
Can you read the Developers Certificate of Origin and follow up with a
Signed-off-by if agreeable?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
