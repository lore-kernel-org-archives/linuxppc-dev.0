Message-ID: <3A68FC06.7BEEA13D@iiic.ethz.ch>
Date: Sat, 20 Jan 2001 03:46:30 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jeff Hartmann <jhartmann@valinux.com>, Gareth Hughes <gareth@valinux.com>,
        linuxppc-dev@lists.linuxppc.org, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >Since your running through klogd, this might not be 'exactly' where you
> >die.  I would be TERRIBLY surprised if you died here.  One thing you
> >have to remember about kernel debugging is that you can't always trust
> >what is in the log.  Here is a technique that works for me when I'm
> >unsure of a piece of code:
>
> Additionally, on PPCs, you have another technique, which is to use
> prom_print or xmon_printf() (the latest one support full printf semantics
> while the first one only supports a simple string).

xmon might really be helpful, but the crash is after the X server blanks the
display, so I wonder if xmon output would be visible?


Thanks to Jeff and everyone for the tips on how to debug this BTW.

Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
