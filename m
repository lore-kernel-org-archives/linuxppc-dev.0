Message-ID: <388B0E9C.DEC92A26@erols.com>
Date: Sun, 23 Jan 2000 14:22:20 +0000
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: "Michael R. Zucca" <mrz5149@acm.org>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Stock 2.2.14 won't boot
References: <l03130300b4aef8bd7dd2@[24.218.140.90]> <l03130300b4afbdf43e5f@[24.218.140.90]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michael R. Zucca" wrote:

> No errors during make, otherwise I wouldn't have a kernel to boot :-)
>

Good call :)

>
> >What fails during boot..?
>
> BootX switches to the black screen where it informs me of the kernel
> version and a few address offsets (like video address, etc.) All of this is
> normal. It just hangs there and doesn't progress.
>

Okay, well, I might work backwards, see what is the last thing that gets outputed,
and try either disabling that, or whatever would come next...

>
> >What are you
> >configuring into the kernel that is causing it to fail...?
>
> Nothing especially spectacular. 604, PowerMac, ati framebuffer, bootX
> console support, pmac serial support, pmac floppy support, vga console,
> mace ethernet, adaptec PCI scsi support, internal SCSI support (53C support
> not the other kind), DMA sound for awacs, some file systems, PPP, etc.
>

I might make sure that you don't have multiple things compiled for the same
support (eg. powermac floppy support, atapi floppy support and pc floppy
support...)

>
> I'm not compiling in anything I haven't in past versions.
>
> I am booting off of a drive attached to the PCI scsi card but that
> shouldn't matter as this works fine from older kernels.
>

<drawing a blank>

HTH
--Nelson Abramson

--
"Every time you get a dialog box you don't understand, you ought to get a nickel
 from Microsoft, and every time it crashes, you should get a dollar.  That would
 make Bill Gates homeless and me a rich man." --Ben Schneiderman, University of
Maryland computer science professor
Courtesy of 1984: http://www.1984-online.com/facts.html


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
