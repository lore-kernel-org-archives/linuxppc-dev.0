Message-ID: <37D357E0.7E648C4A@jlc.net>
Date: Mon, 06 Sep 1999 01:57:52 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GLIBC wont compile for MPC860
References: <19990906011506.87848730@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> I think newlib would be a promising candidate given its emphasis on small size,

Yeah, I suppose we should look at it.  It is nice to use something
already ported and compiled for the PPC, though.  Keeping it all
in the family makes it much easier as lots of other people are
using it.


> My application also needs threads, but I'm hoping I might be able to drop

I just use clone() straight away and I like the implementation
of Linux threads.


> ...I'll just drop lots of RAM in and link statically against glibc-2.1.2.

You may not need lots of RAM for a static linked application.  The
linker only pulls what it needs form the library.  I have done
several applications where static linking required both less
file system storage and real memory space.


> Sure, but I'm cross compiling from an Intel box and it would be nice to be able


If you ever used a Linux/PPC development host (IBM, Motorola, Apple)
you would never use an Intel box for this stuff.  It is so much
faster and easier with a PPC host.


> Any chance you could put your libc-1.99 (or a pointer to it) up at
> ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/ ?

It's been there a long time....libc-1.99-8xx.somthing_or_other.
It's compiled with the -mcpu=860 flag, has the cache line stuff
patched (so you can run copyback on the 8xx), and has the floating
point assembler instructions removed.  It was built from
glibc-0.961212-1o, and is a tar image.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
