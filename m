Message-ID: <383C4E64.5EF3D193@jlc.net>
Date: Wed, 24 Nov 1999 15:45:24 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: raphael.bossek@solutions4linux.de
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: newbie: get ppc823fads working with linux 2.3.x kernel...
References: <E11qX1y-0007yx-00@mx00.kundenserver.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


raphael.bossek@solutions4linux.de wrote:


> i tried here to cross-compile the unstable linux kernel for the FADS
> ppc823 evaluation board but i get ONLY errors while compiling... For
> instance the serial.c source does not compile or other stuff too...


I guess I didn't write this enough times in the notes....Do not, do not,
configure _any_ of the serial I/O options, and many other things, like
CONFIG_VT.  When you select 8xx for the processor type, the proper
serial I/O selections are automatically made to use the internal
CPM serial ports.


> Where will be CONFIG_FADS #defined ?


Somewhere, someplace, someday, when I get around to making the CVS
updates.  It was a configuration option a very long time ago, it
never worked, I couldn't test it, so I removed it.  I will put it
back in based upon tested patches from others......

Get Magnus Damm to send you his (F)ADS patches (which he was going
to send to me :-)......

Get on the linuxppc-embedded mailing list.  Search the old mail
archives for FADS messages.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
