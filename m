Date: Thu, 23 Nov 2000 09:47:13 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Avery Pennarun <apenwarr@worldvisions.ca>
cc: Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <20001122143042.A28078@worldvisions.ca>
Message-ID: <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Linux-PPC (basically the Apple computers, any other Linux/PPC-subset
> > using it ?) uses the PMU, and pmud for power management. I don't think
> > that anybody wants to write an APM support for Power Macs (not me
> > anyway).
>
> Not APM support exactly... simply support for the same interface.  Just like
> powermacs have totally different sound systems and still use /dev/dsp.
> /proc/apm and /dev/apm_bios are so simple that it should be easy to convince
> any power management system to provide those API's.

The info logged to /proc/apm is currently logged to /etc/power/apm. I have
no idea what /dev/apm does aside from providing that log info, and I have
no clue what /dev/apm_bios does, either. There should be no major problems
duplicating the pmu logging code in the kernel, and interfacing that with
some apm glue code, assuming the apm interface is reasonably architecture
independent. I just don't see a good reason to change from pmud to apmd,
if that's what you're suggesting.

CC: to linuxppc-dev where this discussion really should be.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
