Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 3D39E67C4A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 02:57:26 +1000 (EST)
Date: Mon, 18 Jul 2005 09:57:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Grant Likely <glikely@gmail.com>
Message-ID: <20050718165724.GE4370@smtp.west.cox.net>
References: <528646bc0507170006540ac67a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0507170006540ac67a@mail.gmail.com>
Cc: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: Register definition for MPC52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Jul 17, 2005 at 01:06:03AM -0600, Grant Likely wrote:
> Here are additional register definitions for the MPC52xx.  CDM clock
> enables and port config bit settings in mpc52xx.h.  Registers needed
> to support non-UART PSC modes in mpc52xx_psc.h.  Drivers which use
> these regs/bits are to follow once I'm happy with them, but I thought
> that others may be interested in them now.
> 
> Cheers,
> g.
> 
> Signed-off-by: Grant Likely <grant.likely@gdcanada.com>

These should be held off until the drivers are ready (and really only
what the drivers need).  Thanks!

-- 
Tom Rini
http://gate.crashing.org/~trini/
