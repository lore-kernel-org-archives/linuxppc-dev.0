To: linuxppc-dev@lists.linuxppc.org
Subject: Re: recent fixes in devel tree
References: <14786.65401.393966.936283@argo.linuxcare.com.au>
	<8xk8cch9i7.fsf@s63.informatik.uni-bremen.de>
	<39C382DF.772F2B99@mvista.com>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 17 Sep 2000 18:01:13 +0200
In-Reply-To: Dan Malek's message of Sat, 16 Sep 2000 10:25:35 -0400
Message-ID: <8xk8cb57p2.fsf@s63.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek <dan@mvista.com> writes:

>
> Holger Bettag wrote:
>
> > P.S.: BTW, is there a general consensus wether or not AltiVec
> >       enhancements in the kernel would be a good thing.....
>
>
> What kind of enhancements?  I do a fair amount of audio/video
> processing on my G4 with the current gcc/Altivec tools.  I found only
> one minor bug in the exception handler that I fixed a while back.
>
> We have been discussing some of the vector load/store/touch as both
> enhancements to the kernel and glibc.  It is a little more challenging
> in the kernel because we would have to then keep some of the vector
> context around for the kernel, but in a very constrained case we could
> probably get some speed ups with that.
>
I know too little about the kernel to suggest specific tunings. I
thought along the lines you mention, inserting a 'data stream touch'
here and there for improved bus utilization, occasional use of AltiVec
code where it tends to speed things up a lot, like doing checksums for
software RAIDs or other fast I/O channels. Maybe 'generic' video
acceleration of the OpenFirmware framebuffer device, or something like
that. (Maybe I/O en-/decryption, if such functionality ever ends up in
the kernel.)

I mainly wanted to know wether there are efforts underway to make the
use of AltiVec in the kernel a no-brainer (like: "just pass -fvec and
use the AltiVec-'macros'!"), or wether it will be only for wizards at
the bleeding edge.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
