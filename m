Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id D716667A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 09:26:44 +1100 (EST)
Date: Wed, 23 Feb 2005 15:26:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Chapman <jchapman@katalix.com>
Message-ID: <20050223222637.GN345@smtp.west.cox.net>
References: <421CEEA2.2080308@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421CEEA2.2080308@katalix.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PATCH: add mv64x60 GPP IO pin/IRQ register definitions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2005 at 08:59:14PM +0000, James Chapman wrote:

> Add mv64x60 GPP IO pin/IRQ register definitions

[snip]
>  #define	MV64x60_IRQ_TIMER_6_7			11
> +#define MV64x60_IRQ_P1_GPP_0_7			24

Please use consistent spacing.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
