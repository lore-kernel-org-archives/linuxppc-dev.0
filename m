Date: Mon, 25 Jun 2001 16:35:04 -0500 (CDT)
From: Kumar Gala <galak@ibmoto.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: software FP support?
Message-ID: <Pine.GSO.4.05.10106251633130.22421-100000@softail.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was wondering what the current state of software floating point support
was in the PowerPC embedded world.

I am trying to build a glibc with soft-fp to get a /bin/sh that does not
setup the fpu state.  I was wondering if someone has already gone through
this trouble or how people have been handling this.

I know that the kernel has support for soft-fp handling which would allow
userland and libc to still use FP code but that seems expensive.

Any information would be helpful.

thanks

 - kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
