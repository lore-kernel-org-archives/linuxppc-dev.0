Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id B7DF368077
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 07:31:46 +1000 (EST)
Date: Fri, 26 Aug 2005 14:31:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050826213144.GE5541@smtp.west.cox.net>
References: <Pine.LNX.4.61.0508261415080.29975@nylon.am.freescale.net>
	<f0351d402e64b569bbcfc16fa921d860@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0351d402e64b569bbcfc16fa921d860@embeddededge.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2005 at 04:13:04PM -0400, Dan Malek wrote:
> 
> On Aug 26, 2005, at 3:15 PM, Kumar Gala wrote:
> 
> >While ppc32 has the CONFIG_HZ Kconfig option, it wasnt actually being
> >used. Connect it up and set all platforms to 250Hz.  This pretty much
> >mimics the ppc64 patch from Anton Blanchard.
> 
> Why do we keep cranking up this clock frequency?  Do we really need
> it running that fast?  Is it time for someone with RTOS experience to
> implement a real scheduled clock queue in Linux instead of just
> wasting interrupts decrementing a counter waiting for the next
> event to expire?  :-)  If the user "ticks" are still 100 Hz, don't we 
> need
> something that is an integer multiple of that for at least an attempt
> at getting it close to what a user would request?

So 250 is supposed to be the best choice of power vs latency and such.
But hey, there's nothing stopping us from setting all of the embedded
configs back down to 100 :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
