Message-ID: <38713F39.E72D77FF@ctam.com.au>
Date: Tue, 04 Jan 2000 11:30:49 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
CC: Alan Mimms <alanm@unforgettable.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross-compiling & debugging embedded-linux apps
References: <386C3615.E14AE6DD@ctam.com.au>
	 <19991231.6583200@alanm.penguinpowered.com> <386CD4AD.A0311DD9@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Lewis wrote:

> Alan Mimms wrote:
>
> > You know about the ldd command?  Do 'ldd bjs1-shared' to see what
> > libraries you need for your shared executable and make sure they're
> > there and built with no floating point.  When you compile and link,

Yep, but ldd doesn't seem to exist in my cross-tools.  Is it part of gcc,
binutils or some other package ?


> > you're using '-mcpu=860' or '-msoft-float', right?  That also could be
> > a problem for you.

I'm using -mcpu=860 but I am not specifying -msoft-float.  This shouldn't be a
problem for a simple program that continuously prints out a string using puts().
The static version runs so it is some kind of dynamic library loader problem I
suspect.

I've had some replies from the cross-gcc mailing list with some suggestions.
I'll post any results worth mentioning.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
