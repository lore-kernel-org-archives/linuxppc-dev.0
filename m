Date: Tue, 28 May 2002 11:39:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] enhancements to MPC8260 serial driver ...
Message-ID: <20020528183927.GJ1295@opus.bloom.county>
References: <17963.1022564256@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17963.1022564256@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 03:37:36PM +1000, Murray Jensen wrote:

> - configure any, or all, SMC and SCC ports to be serial ports; the only
>   wiring setup that allows this is for SCC[1-4]<=>BRG[1-4] and SMC[1-2]
>   <=>BRG[7-8]
> - support serial console and/or kgdb port on any, or none, SMC or SCC port
> - permanent mapping of S[MC]Cn<=>ttySn i.e. ttyS0 is always SMC1, ttyS1 is
>   always SMC2, ttyS2 is always SCC1, and so on.
> - most i/o pin configurations covered by simple config options i.e. SCC2
>   and SCC3 have "primary" or "secondary" i/o pin configurations
> - supports using an external clock source for any BRG, instead of BRGCLK

Can you split this up into 5 logical patches?  Thanks.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
