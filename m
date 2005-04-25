Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 8AB5167B1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 00:50:41 +1000 (EST)
Date: Mon, 25 Apr 2005 07:50:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050425145029.GD3112@smtp.west.cox.net>
References: <20050413195713.GF11131@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050413195713.GF11131@logos.cnet>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] attempt to remove misc-embedded.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2005 at 04:57:13PM -0300, Marcelo Tosatti wrote:

> 
> Hi Tom,
> 
> This is an attempt to move remove misc-embedded.c by moving its quirks to
> misc.c. 
> 
> It needs further fixing and cleaning, for sure. 

I like the idea of deleting misc-embedded.c, but I don't think we should
haven't make many changes to misc.c (except perhaps abstracting away a
few more hunks of it) as I _think_ most of the cpu-specific stuff can be
moved around now to the misc-board.c files.

> Are there any major disagreements about the change? 
> Might need to define a bd_t structure for all ppc's? 

That's something to be left for the flat OF tree thread. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
