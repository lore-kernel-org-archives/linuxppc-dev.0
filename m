Message-ID: <3AE57C07.B06406B5@iiic.ethz.ch>
Date: Tue, 24 Apr 2001 15:13:43 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
References: <Pine.LNX.4.05.10104240948110.22858-100000@callisto.of.borg>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Mon, 23 Apr 2001, Ethan Benson wrote:
> > On Tue, Apr 24, 2001 at 07:53:38AM +0200, Michel Lanners wrote:
> > > I have ECN compiled in all my 2.4 kernels. They are building right now
> > > without ECN.... We'll see.
> > >
> > > <a compile & reboot later>
> >
> > there is a sysctl variable that disables this at runtime you know ;-)
> > i don't remember where it is offhand, sysctl -a | grep ecn or find
> > /proc -name '*ecn*' -print should find it.
> >
> > > Yup, that seems to be the problem. rsync works again for me on
> > > penguinppc. So I guess that some device close to penguinppc.org doesn't
> > > support ECN.....
> >
> > probably turning on ecn is more trouble then its worth right now,
> > unfortuanatly...
>
> | tux$ cat /proc/sys/net/ipv4/tcp_ecn
> | 1
> | tux$
>
> I have it enabled on all my machines running 2.4.x. So far no problems.

You're lucky, it used to keep me from establishing any TCP connections to the
outside world through an ISDN router.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
