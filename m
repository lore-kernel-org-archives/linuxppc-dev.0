Date: Mon, 10 Jul 2000 14:12:08 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mmporter@home.com>
cc: Michael Lundkvist <ml@epact.se>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <20000708162915.A11060@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.HPX.4.10.10007101358110.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 8 Jul 2000, Matt Porter wrote:

>
> On Thu, Jul 06, 2000 at 07:32:49PM +0200, Michael Lundkvist wrote:
> >
> > Gabriel Paubert <paubert@iram.es> writes:
> > > Under 2.2.12 dd if=/dev/hda of=xxx bs=512 count=1 and see what comes out.
> > > Can PPCBUG actually boot from these disks ?
>
> PPCBUG expects a little endian partition table, so no.

Ok, my queston was rather: does PPCBUG have support for generic IDE
interfaces or not ?

> I really have to recommend against that.  Once Ramix sees the icky PPCBUG
> code they will hate as much as I do.  I gave well documented changes to
> the PPCBUG guys so that BUGBOOT wasn't needed to boot a kernel from
> FLASH on a PowerPlus board but they haven't incorporated those changes
> after a full year now. :)

The other change I would like to see in PPCBUG is that it complies with
the documentatioon that claims that its services will work when the MMU is
enabled. At least on 603e it does not work since it sets the MSR IP bit
and then silently crashes in the TLB handlers. I doubt that this would
work on a 604 or a 750 either (I did not test it), but if you get an ISI
or DSI exception, you are probably screwed too.

If people volunteer to write a new MVME bootrom from scratch (or a working
OF), I shall be the first in line to get it and flash it in my boards.
ppc*BUG* deserves its name, at least the second part :-(

	Regards,
	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
