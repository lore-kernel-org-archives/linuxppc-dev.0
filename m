Message-ID: <3BD5E8B4.ED0BD911@mvista.com>
Date: Tue, 23 Oct 2001 18:01:24 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging, kernel port status update
References: <3BD5DE9F.17679D05@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:

> 0) I built a generic binutils/gcc/glibc for the PPC -- notes
> available.

It's probably easier just to download this from someplace like mvista.com.

> I may have to tweak this compiler if I get FPU support along w/
> instructions which aren't a part of this uP's instruction set.

There should be sufficient options to the compiler that wouldn't
require rebuilding.  I suspect telling it to use a 603 core with 405
instruction scheduling will make it work.  Actually, just a 603
will make it work, the additional scheduling hints may improve
performance.

The bigger challenge is the kernel mofication necessary to properly
context switch the FPU on this part.

> -- the #if 0 portion was what was already in head_4xx.S (w/o the if 0)
> but didn't work. the #else case was taken from head.S and seemed to
> work.

You are working with a really old kernel.  Find a newer one.  I would
recommend the 2_4_devel tree for what you are doing.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
