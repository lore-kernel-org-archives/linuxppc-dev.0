Date: Mon, 7 Feb 2000 10:08:22 -0500 (EST)
From: Quality Quorum <qqi@world.std.com>
To: "William A.Gatliff" <bgat@usa.net>
cc: diekema_jon <diekema@bucks.si.com>, all@cideas.com,
        linuxppc-embedded@lists.linuxppc.org, gdb@sourceware.cygnus.com
Subject: Re: [Looking for the PPC gdb debug stubs]
In-Reply-To: <20000207023248.17506.qmail@nwcst323.netaddress.usa.net>
Message-ID: <Pine.SGI.3.95.1000207100549.24603E-100000@world.std.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On 6 Feb 2000, William A.Gatliff wrote:

> Jon:
>
> > In your 9/99 article in Embedded Systems Programming, you hint
> > about the Power PC gdb debug stubs being in progress.  Can you
> > provide with any details like:
> >
> > - Is the effort complete?
>
> Actually, the "port" was my sending a copy of the SH-2 stub to someone who was
> working on PPC.  They promised to port it and return, but I never heard back
> from them.
>
> > - If so, where can I find the PPC gdb debug stubs?

You can try the thing I put togehter at
http://www.std.com/qqi/labslave/rproxy.html

Among other things it provides an application bridge between
wiggler (BDM debugger from macraigor) and gdb remote protocol.
>
> You can now find the complete SH-2 stub at www.sourceforge.net.  Do a search
> for "gdbstubs".
>
> It's a complete rewrite from the ESP days, designed for more portability.
>
>
> If you're familiar with the PPC, then you could always do the port yourself.
> eCos has a stub as well, and it shouldn't be too hard to meld it into my
> sources.  I don't have any PPC hardware, though, so I'm understandably wary of
> trying to offer much help with the hardware-specific stuff.  If I had the
> hardware, though...
>
> b.g.
>
>
>

Thanks,

Aleksey


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
