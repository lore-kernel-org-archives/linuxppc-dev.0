Message-ID: <3829CE16.F87DBD4D@jlc.net>
Date: Wed, 10 Nov 1999 14:57:10 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: kris_kelvin@excite.com, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Looking for glibc-0.961212-1o.src.rpm
References: <942104017.13033.909@excite.com> <382768B8.BEDD4E41@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:


> You need to make a patch to dl-machine.h so you can use
> the 8xx copyback cache with dynamic libraries.....different


I didn't find the patch, but I found the file.  I put it on
the ppc.kernel.org server in the embedded directory.  The changes
are minor, I'm sure you can update any version of the file from
this.  Actually, I think that patch would work on any PPC processor,
unless there are some alignment restrictions in the flush_cache
functions called.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
