From: Jeff Kowing <jeffrey.d.kowing@nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16148.6373.869623.908659@igor.jsc.nasa.gov>
Date: Tue, 15 Jul 2003 10:08:21 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DENX ELDK Kernel
In-Reply-To: <3F140928.60403@imc-berlin.de>
References: <20030715135119.5782CC6D82@atlas.denx.de>
	<3F140928.60403@imc-berlin.de>
Reply-To: jeffrey.d.kowing@nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 10 of 10 points :-)

I'm on a role, so I'll try again against my better judgement.

Steven Scholz writes:
 > If I'd built the ELDK from scratch and used Linux-2.4.20 include files
 > to build "glibc (and all the rest of the target ELDK apps)" I should
 > build my "applications against the newer Linux kernel"! Shouldn't I?

Yes, you are correct.  The rule is to always build user space
applications against the same Linux include files that were used to
build glibc.

If, on the other hand, you are compiling a kernel module, then you
need to build it against the actual Linux kernel version you are
running.

 >
 > And in general: shouldn't I used a glibc that "matches" the kernel
 > version?

I think that is the "safest" way of doing things, but apparently not
usually necessary.  People upgrade their kernels all the time on their
native platforms without rebuilding their glibc. I believe some effort
is made to maintain binary compatiblity between glibc and the kernel -
but I'm sure it is not guaranteed.

Regards,
Jeff

--
Jeff Kowing <jeffrey.d.kowing@nasa.gov>
All opinions expressed are my own and not of my employer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
