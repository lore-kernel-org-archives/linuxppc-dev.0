Message-ID: <3B3C30CD.34B20F02@mvista.com>
Date: Fri, 29 Jun 2001 03:39:57 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: jtm@smoothsmoothie.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
References: <20010626160844.A20988@shamus.smoothsmoothie.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jtm@smoothsmoothie.com wrote:

> .... The buffer memory will get filled
> via DMA, and therefore must not be cached.

Huh????  The 8260 is cache coherent, you don't need to do that.

For processors that are not cache coherent (4xx and 8xx), there
are standard 'consistent_alloc()' functions available.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
