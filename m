Date: Thu, 23 Nov 2000 03:08:08 -0800
From: Avery Pennarun <apenwarr@worldvisions.ca>
To: daenzerm@student.ethz.ch
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
Message-ID: <20001123030808.A13371@worldvisions.ca>
References: <20001122143042.A28078@worldvisions.ca> <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de> <20001123020959.A11952@worldvisions.ca> <3A1CF40F.5A509ACB@relog.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3A1CF40F.5A509ACB@relog.ch>; from daenzer@relog.ch on Thu, Nov 23, 2000 at 11:40:15AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 23, 2000 at 11:40:15AM +0100, Michel Dänzer wrote:

> > > > /proc/apm and /dev/apm_bios are so simple that it should be easy to
> > > > convince any power management system to provide those API's.
> > >
> > > The info logged to /proc/apm is currently logged to /etc/power/apm. I
> >
> > Is this a typo?  Why is status information in /etc?
>
> Because it's from pmud, which can't create /proc entries.

Then it should go in /var, I think.  We have standards for this stuff.
(FSSTND, FHS, Debian policy.)  I might want to mount /etc read-only (and
/usr too, while I'm at it)... and this sounds like it would prevent me from
doing so.

Thanks,

Avery


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
