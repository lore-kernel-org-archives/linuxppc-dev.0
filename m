Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 5C4792BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 04:48:40 +1100 (EST)
Date: Wed, 5 Jan 2005 10:48:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: alebas@televes.com, Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050105174838.GF4213@smtp.west.cox.net>
References: <1102585377.41b81e218d6df@webmail.televes.com:443>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1102585377.41b81e218d6df@webmail.televes.com:443>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.10 running on mpc8272ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 09, 2004 at 10:42:57AM +0100, alebas@televes.com wrote:

> Hi to all,
> 
> Finally I got my mpc8272ads board running the 2.6.20-rc1 kernel.
> The trick was:
> 
> First, I had to comment out the BCSR modification for second UART
> in m82xx_board_init function (arch/ppc/platforms/pq2ads.c). As
> suggested by Dan Malek, MMU is still off at this point.

Indeed.  While I had a PQ2FADS for a bit, I had to do that as well.
Kumar, what/why is that needed exactly?  Did I screw up in re-working
the 82xx init stuff and it needs to happen a bit later in boot?

-- 
Tom Rini
http://gate.crashing.org/~trini/
