From: jtm@smoothsmoothie.com
Date: Tue, 26 Jun 2001 16:08:44 -0500
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
Message-ID: <20010626160844.A20988@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.1010626060441.32475C-100000@november.bhjjh.erols.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am looking for a solution to a similar problem. I am writing a
driver for an FCC on the 8260 in transparent mode, and need
to allocate buffer memory. The buffer memory will get filled
via DMA, and therefore must not be cached. Will the following work
correctly?

	vaddr = kmalloc(BUF_SIZE, GFP_DMA);
	paddr = __pa(vaddr);

Thanks.
--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
