Message-ID: <3B674529.F23B92F9@mvista.com>
Date: Tue, 31 Jul 2001 18:54:17 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Grant Erickson <erick205@umn.edu>
Cc: Cindy Peters <cinpet@adaptivemicro.com>,
	"'Dan Malek'" <dan@mvista.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: New Linux PowerPC development
References: <Pine.SOL.4.20.0107311650090.15362-100000@garnet.tc.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We were going to release it, but if you read the lmbench license you
will find out that contrary to popular belief it is not considered "free
software".  Basically if you use lmbench for commerical purposes, or
need to patch it to allow for it to cross compiler, or change it in
anyway, you are not allowed to do anything with it.

So the short answer is we said "screw it", decided not to ship it.  We
will give our patches and tools to (paying) customers on request, but it
just isn't worth our while to deal with these restrictions for the open
source release.  (Sorry..)

FYI, lmbench is actually pretty easy to cross compile.  If I remember
right just do:
make CC=(compiler)
make CC=(compiler) results
make CC=(compiler) rerun

--Mark Hatle
MontaVista Software, Inc.

Grant Erickson wrote:
>
> On Tue, 31 Jul 2001, Cindy Peters wrote:
> > I have downloaded the lmbench software to determine some benchmarking
> > information. I am not sure how to build it for the PPC. I have a cross
> > compiler development environment setup in a subdirectory. Can someone
> > help me with this?
>
> MontaVista reportedly has this as part of their at-cost HHL kit. However,
> I am not aware of any monetarily-free bundles of this cross-compiled for
> various architectures.
>
> It's been on my to-do list to work on this; however, my experience thus
> far is that this is not entirely straightforward to cross-compile based on
> what's in the package at present.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
