Message-ID: <38601997.231F1F6A@ctam.com.au>
Date: Wed, 22 Dec 1999 11:21:44 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linux-embedded: which shell, termcap or ncurses ?
References: <385EE46B.1D97C2D2@ctam.com.au> <385FBC9B.E80D568@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Brendan Simon wrote:
>
> > ... I now need to get a shell running so I can call shell scripts to
> > setup the IP addresses etc via ifconfig (is there any other way ?).
>
> Why don't you just use the binaries from a standard distribution?
> I try to use as much of this as I can, and it seems to make the
> job easier for me.

I want to use Linux in a commercial product.  It's  a security product
and some of our clients require that the source code be available and
that all code can be maintained using a source configuration mangement
system.  All files must be compilable from the SCM using set procedures.
These requirements are part of an evaluation specification that we must
conform to.

I guess one could argue that the procedures would be to compile on a
powerpc machine and transfer the binaries.  At this stage it is not an
option but I will be getting a G4 server in January so life might be
easier.

I'd still prefer to be able to compile all the source for our product.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
