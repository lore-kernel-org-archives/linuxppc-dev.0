Message-ID: <382768B8.BEDD4E41@netx4.com>
Date: Mon, 08 Nov 1999 19:20:08 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: kris_kelvin@excite.com
CC: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Looking for glibc-0.961212-1o.src.rpm
References: <942104017.13033.909@excite.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


kris_kelvin@excite.com wrote:


> I wonder if somebody can point me to a place where I can
> find glibc-0.961212-1o.src.rpm.


I don't have that, but I used glibc-0.961212-1r for my
latest 8xx embedded libraries.  I put the SRPM on the
ppc.kernel.org server, in the embedded directory.  You
certainly don't want to use the -1h version.

You need to make a patch to dl-machine.h so you can use
the 8xx copyback cache with dynamic libraries.....different
cache line size.  Once I find that patch, I'll post it up
there as well.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
