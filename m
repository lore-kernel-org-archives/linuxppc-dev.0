Date: Sat, 28 Aug 1999 18:44:55 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 850 LinuxPPC installation?
In-Reply-To: <199908271827.UAA00377@piglet.cpu.lu>
Message-ID: <Pine.LNX.3.96L.990828184233.3389E-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 27 Aug 1999, Michel Lanners wrote:
> 
> > Here's the IDE info I get before it hangs:
> > hda: DPEA-31080, ATA DISK drive
> > hda: IRQ probe failed (0)
> > hdb: DSAA-3720, ATA DISK drive
> > hdb: IRQ probe failed (0)
> > hdc: IRQ probe failed (0)
> > hdc: IRQ probe failed (0)
> > hdc: no response (status = 0xd1), resetting drive
> > hdc: no response (status =0x80)
> 
> This means the driver is not able to acces the controller for ide1.
> That might be a problem with the IO-port addresses.
> 
> Also, you might want to try patching your kernel with Andre Hedrick's
> multi-platform uniform IDE driver (look at
> ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/). You _might_
> need additional patches to get it to boot; if so, get back to me, and
> I'll produce a diff against my working kernel.

I don't know if you read my most recent info, but after disconnecting the
cdrom drive (hdc), I'm getting lots of 
hda: lost interrupt

My dmesg otherwise looks the same - just drop every mention of hdc. If you
think that uniform IDE driver would help with my current problem let me know
and I'll give it a shot.

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
