To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
References: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu>
	<1065823660.601.0.camel@gaston>
Reply-To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Date: 11 Oct 2003 23:44:22 +0200
In-Reply-To: <1065823660.601.0.camel@gaston>
Message-ID: <hhk77bv495.fsf@pygar.theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Benjamin Herrenschmidt writes:

> I just fixed that in my 2.6 and I'll backport to 2.4 soon

I compiled the latest version of that tree in order to get radeonfb
working on my 17" Powerbook.  A few questions:

1. The resulting kernel is more than 30MB in size.  Is this normal?

2. The accelerated framebuffer has the right size, but flickers a lot.
   offb works fine.

3. XFree86 from Debian/unstable doesn't work whatever I do, I presume
   something along the lines of 4.3.99 would be the appropriate
   version?  If yes, from which source?

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
