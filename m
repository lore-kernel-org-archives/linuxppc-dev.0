Message-ID: <3BE09446.CC614261@midrivers.com>
Date: Wed, 31 Oct 2001 17:16:06 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: building gdb ... no input
References: <20011031213937.C0BC611269@denx.denx.de> <3BE086F8.3A6158DA@midrivers.com> <3BE08DCE.1B2E78BF@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've traced the problem as far as configuring w/ --prefix= pointing
to my ppc tools & glibc home, wanting the tools to be installed
w/ gcc et al.

I haven't debugged it all the way, but the build of readline was
complaining of ambiguous endian-ness because it was picking endian.h
from my ppc include dir ...

So.  I'll build w/o specifying a --prefix dir, and make install
specifying an install_root ...

Time to watch the Simpsons ... Doh!

Mark

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
