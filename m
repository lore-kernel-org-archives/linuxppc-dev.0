Message-ID: <3B954F7D.38D91654@mvista.com>
Date: Tue, 04 Sep 2001 18:02:37 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Edward Swarthout <swarthou@ibmoto.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Assorted patches - number one
References: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com> <15251.459.153586.712142@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> These are the 4xx registers, aren't they?  We had definitions in like
> this before, does anyone remember why they were removed?

The 7450 has a 'software TLB' mode, which would use these registers.
I didn't plan on ever using that mode in Linux, so there really isn't
any need for them to be defined.

I'm also thinking we should move the cache control register definitions
to 'cache.h', to stop the ever growing size of processor.h.  I'm also
a minimalist programmer.....why do we define all of this crap if we
don't use it?  If you want to know how _all_ of the registers and
bits are used, read the programming manual for the processor.......

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
