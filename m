Message-Id: <199909101825.UAA14339@piglet.cpu.lu>
Date: Fri, 10 Sep 1999 20:25:23 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: UW SCSI PCI cards
To: saulngeo@MLE.CO.UK
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
In-Reply-To: <199909101014.AA08041@LONSF24318.MLE.CO.UK>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Sep, this message from Saulnier, Geoff (London) echoed through cyberspace:
> Finally managed to get linuxppc installed, from the CD, onto my Beige G3
> minitower.  It has a PCI Ultra-Wide SCSI card and 2 4Gb UW SCSI disks of
> that card.  I had to install it onto a 1Gig Jaz cart because of the
> following problems:
> 
> No matter how well partitioned my drives were (with Mac pdisk), the intaller
> would not see them, and pdisk in the linux X installer environment would not
> see them.  In fact, it would see not partitions at all of any kind.

That depends on the exact model of PCI SCSI card you have. If it's an
original Apple part, it should be recognized by the installer. If not,
chances are that it doesn't contain OpenFirmware code to make it
recognized upon boot; so the installer will not see it.

Plus, I don't know what SCSI drivers are built into the installer.

> So, my questions are:
>   -  what PCI UW SCSI cards are supported in the final version

Basically all that Linux supports, although some more exotic ones might
not work on PowerPC...

>   -  are there any plans to support others (I am assuming that the one that
> came in my box is not supported!)

Sure.. hack them yourself so that they work on PowerPC ;-)

>   -  does this problem sound like it has nothing to do with the card?

As I said, it's either the card lacking OF code, or the installer
lacking the proper driver.

If the latter is your problem, you can always install on the Jaz, then
builkd a kernel including the driver for your SCSI board, then copy the
whole system over.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
