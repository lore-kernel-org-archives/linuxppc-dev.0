Message-ID: <39C382DF.772F2B99@mvista.com>
Date: Sat, 16 Sep 2000 10:25:35 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: recent fixes in devel tree
References: <14786.65401.393966.936283@argo.linuxcare.com.au> <8xk8cch9i7.fsf@s63.informatik.uni-bremen.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag wrote:

> P.S.: BTW, is there a general consensus wether or not AltiVec
>       enhancements in the kernel would be a good thing.....


What kind of enhancements?  I do a fair amount of audio/video
processing on my G4 with the current gcc/Altivec tools.  I found only
one minor bug in the exception handler that I fixed a while back.

We have been discussing some of the vector load/store/touch as both
enhancements to the kernel and glibc.  It is a little more challenging
in the kernel because we would have to then keep some of the vector
context around for the kernel, but in a very constrained case we could
probably get some speed ups with that.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
