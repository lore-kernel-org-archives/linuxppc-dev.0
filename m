Message-ID: <3A1CF40F.5A509ACB@relog.ch>
Date: Thu, 23 Nov 2000 11:40:15 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Avery Pennarun <apenwarr@worldvisions.ca>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
References: <20001122143042.A28078@worldvisions.ca>
	 <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de> <20001123020959.A11952@worldvisions.ca>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Avery Pennarun wrote:

> > > Not APM support exactly... simply support for the same interface.  Just
> > > like powermacs have totally different sound systems and still use
> > > /dev/dsp.
> > > /proc/apm and /dev/apm_bios are so simple that it should be easy to
> > > convince any power management system to provide those API's.
> >
> > The info logged to /proc/apm is currently logged to /etc/power/apm. I have
>
> Is this a typo?  Why is status information in /etc?

Because it's from pmud, which can't create /proc entries.


> > independent. I just don't see a good reason to change from pmud to apmd,
> > if that's what you're suggesting.
>
> It's always better, IMHO, to keep Linux userspace as similar as possible
> between different architectures.  If pmud has features that apmd doesn't
> have, or vice versa, I would rather merge them than keep them separate.  In
> the process, we might as well work on making the kernel interfaces similar
> too.  That's the whole _point_ of the kernel.

I agree there.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
