Date: Thu, 23 Nov 2000 12:15:32 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Avery Pennarun <apenwarr@worldvisions.ca>
cc: daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <20001123030808.A13371@worldvisions.ca>
Message-ID: <Pine.LNX.4.10.10011231212270.18581-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > > The info logged to /proc/apm is currently logged to /etc/power/apm. I
> > >
> > > Is this a typo?  Why is status information in /etc?
> >
> > Because it's from pmud, which can't create /proc entries.
>
> Then it should go in /var, I think.  We have standards for this stuff.
> (FSSTND, FHS, Debian policy.)  I might want to mount /etc read-only (and

Granted. pmud was first packaged for LinuxPPC which is rpm based and cares
about FHS about as much as RedHat does. I'll look for a better place to
stick the fifo.

Re: mounting /etc readonly: how do you handle /etc/mtab in that case? :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
