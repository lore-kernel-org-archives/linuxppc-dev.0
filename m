Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BB25C4D.7708F14C@opensource.se>
Date: Thu, 27 Sep 2001 00:53:01 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Josh Huber <huber@alum.wpi.edu>
Cc: Grant Erickson <erick205@umn.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Solutions for Fast Software Upgrade in Linux/PPC
References: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu> <87n13idk7e.fsf@mclinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I recommend a combination of a simple bootloader and
a reboot-linux-in-linux piece of software.

You can find miniboot - a safe and simple bootloader
at http://opensource.se/projects/
With a clever-designed upgrade application it's possible
to update the flash in a fail-safe way.

One neat feature is that miniboot runs without any external RAM,
which makes it possible to keep the RAM-code in a upgradeable
image.

I also have a driver, relf, (Reboot ELF) that makes it
possible to reboot an ELF directly from Linux.
It has booted Linux, vxWorks and pSOS. mpc8xx only.
If you're intrested - give me a mail and I will send it to you.

Good luck /

Magnus

Josh Huber wrote:
>
> Grant Erickson <erick205@umn.edu> writes:
>
> [snip]
>
> I'd also recommend the fast-reboot option, but since no one mentioned
> yet I'll suggest Werner Almsberger's bootimg utility.
>
> Take a look at:
> <URL:ftp://icaftp.epfl.ch/pub/people/almesber/misc/>
>
> specifically, bootimg-current.tar.gz
>
> Also, in ../booting/ there is a paper describing the
> method. (bootinglinux-current.ps.gz)
>
> I've tested this many times (we use it at Mission Critical for our
> kernel crash dump system), and if you're looking for fast reboots this
> is the way to go.
>
> Unfortunately, it doesn't solve the upgrading of the ROM issue.
>
> For the lazy who don't want to look at the references, what this
> allows you to do is boot a linux kernel, using an already loaded Linux
> kernel.
>
> ttyl,
> --
> Josh Huber
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
