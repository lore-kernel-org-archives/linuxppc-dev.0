From: Brad Boyer <flar@marcus.pants.nu>
Message-Id: <199908311213.FAA06812@marcus.pants.nu>
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
To: ddkilzer@computer.org (David D. Kilzer)
Date: Tue, 31 Aug 1999 05:13:17 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v0313030fb3efcb9a9d0f@[192.168.1.1]> from "David D. Kilzer" at Aug 30, 99 00:54:50 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David D. Kilzer wrote:
> Is anyone running LinuxPPC with a Daystart 604e 200MHz dual-processor card?

Yes, I have a DayStar nPower400 card, which I assume is the same card.

> I've compiled 2.2.12 from CVS source, and the kernel oops with some sort of
> MMU fault.  (I can print out the exact error if necessary.)

I've had some interesting memory problems with mine, as well.  However,
various things like moving around the RAM, and leaving the MacOS running
for a while can magically fix problems part of the time.

> I'm using BootX 1.1.3 with only my root partition (/dev/sdb9) defined.

I always use OF to boot, but other people say it works with BootX.

> Any ideas?  I haven't tried adding debug code or perusing the source, yet,
> but I expected this configuration to work out-of-the-box since Daystar and
> Apple SMP cards are supposed to be essentially the same.

Well, this sort of thing has come up on the lists before.  You could search
the archives.  Past that, try shuffling around your hardware.  Linux seems
to be very picky about running SMP.

	Brad Boyer
	flar@pants.nu


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
