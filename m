Date: Wed, 20 Oct 1999 22:06:37 -0600
From: Cort Dougan <cort@ppc.kernel.org>
To: Graham Stoney <greyham@research.canon.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
Message-ID: <19991020220637.A18258@chimaera.ppc.kernel.org>
References: <003e01bf1a9e$59f44980$0201a8c0@home> <19991021034941.C067A659@elph.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991021034941.C067A659@elph.research.canon.com.au>; from Graham Stoney on Thu, Oct 21, 1999 at 01:49:41PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've added an arch-specific heartbeat as of 2.3 to the timer handler that
could easily be setup to handle this.

I don't want the boot code 'littered' with calls to this, though.  It'd be
nice if the timer handler could take care of this until the user app could
take it over.  If the time between time_init() and the sti() is too great
in start_kernel() that may not be possible.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
