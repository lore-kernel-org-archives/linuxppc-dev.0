Date: Thu, 23 Nov 2000 02:09:59 -0800
From: Avery Pennarun <apenwarr@worldvisions.ca>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
Message-ID: <20001123020959.A11952@worldvisions.ca>
References: <20001122143042.A28078@worldvisions.ca> <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Thu, Nov 23, 2000 at 09:47:13AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 23, 2000 at 09:47:13AM +0100, Michael Schmitz wrote:

> > Not APM support exactly... simply support for the same interface.  Just
> > like powermacs have totally different sound systems and still use
> > /dev/dsp.
> > /proc/apm and /dev/apm_bios are so simple that it should be easy to convince
> > any power management system to provide those API's.
>
> The info logged to /proc/apm is currently logged to /etc/power/apm. I have

Is this a typo?  Why is status information in /etc?

> no idea what /dev/apm does aside from providing that log info, and I have
> no clue what /dev/apm_bios does, either. There should be no major problems

The /dev device selects true for read() when a power event happens (such as
a user suspend request or battery status change) and can be written to allow
a user process to initiate a system suspend.

> independent. I just don't see a good reason to change from pmud to apmd,
> if that's what you're suggesting.

It's always better, IMHO, to keep Linux userspace as similar as possible
between different architectures.  If pmud has features that apmd doesn't
have, or vice versa, I would rather merge them than keep them separate.  In
the process, we might as well work on making the kernel interfaces similar
too.  That's the whole _point_ of the kernel.

Have fun,

Avery

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
