Message-ID: <39C6D82C.38A7D9D1@mvista.com>
Date: Mon, 18 Sep 2000 23:06:20 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: recent fixes in devel tree
References: <14786.65401.393966.936283@argo.linuxcare.com.au>
		<8xk8cch9i7.fsf@s63.informatik.uni-bremen.de>
		<39C382DF.772F2B99@mvista.com> <8xk8cb57p2.fsf@s63.informatik.uni-bremen.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag wrote:

> I know too little about the kernel to suggest specific tunings.

Suggestions always make people think......

> .... I
> thought along the lines you mention, inserting a 'data stream touch'
> here and there for improved bus utilization, occasional use of AltiVec
> code where it tends to speed things up a lot,

The data stream touch is maybe useful in some very specific places.
I have written user level performance tests to see where it is
beneficial, and you have to be careful.  Yes, it can speed things
up when all of the bits line up just right, but you can also screw up
with it as well :-).  Oh, I use it, but it isn't a quick and generic
solution.

> I mainly wanted to know wether there are efforts underway...
> .... or wether it will be only for wizards at
> the bleeding edge.

Oh, there are a few.  Bleeding edge is a good description, but
wizard is more like 'wizzing' (perhaps into the wind :-) in some
cases....

I'm working on several user applications (audio, video, MPEG, etc)
that utilize Altivec, so I'm getting a pretty good idea how to tune
data streams and caches.  Some of this will probably find it's way
into the C library (and has already in some of the MPEG libraries)
for performance enhancement.  The challenge in the kernel is making
the Altivec context available for the kernel.  The Altivec is faster,
but it comes at a higher set-up cost that you also have to consider.
We'll get some in there.  It is definitely hardware that will get
utilized more and more.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
