From: jtm@smoothsmoothie.com
Date: Fri, 29 Jun 2001 11:30:55 -0500
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
Message-ID: <20010629113055.A30951@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B3C30CD.34B20F02@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 29, 2001 at 03:39:57AM -0400, Dan Malek wrote:
>
> jtm@smoothsmoothie.com wrote:
>
> > .... The buffer memory will get filled
> > via DMA, and therefore must not be cached.
>
> Huh????  The 8260 is cache coherent, you don't need to do that.

OK. I've had more experience with the 860, and just assumed the
8260 had the same no cache requirement on DMA. Thanks.

--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
