Subject: Re: kernel executing from flash
To: robt@flyingpig.com (Rob Taylor)
Date: Tue, 28 Mar 2000 10:04:10 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000001bf97ca$1a27d7f0$b400a8c0@eventhorizon> from "Rob Taylor" at Mar 27, 2000 09:54:46 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000328000410.6770E35610@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > For our (non-linux) embedded systems, if we're going to run from
> > flash, we store the executable in flash uncompressed.  Price is an
> > issue which favors RAM, but speed issues no longer favor RAM - the new
> > intel burst flash is faster than RAM in one of our systems.

Rob Taylor writes:
>
> isn't it only faster for burst reads tho? that sort of speed increase
> doesn't really help when running code..

I think you might be mistaken here. Code accesses tend to be very linear, and
since the Instruction cache loads entire lines at a time, burst accesses are a
big win for code.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
