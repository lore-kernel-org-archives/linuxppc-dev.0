MIME-Version: 1.0
Message-Id: <v04210102b4281fcfcf43@[17.203.21.242]>
In-Reply-To: <38025915.7E56440D@Colorado.EDU>
References: <Pine.SOL.4.10a.9910111932100.13312-100000@red.csi.cam.ac.uk>
 <38024BB1.DACA1A47@andrew.cmu.edu> <38025915.7E56440D@Colorado.EDU>
Date: Mon, 11 Oct 1999 16:27:55 -0700
To: Alex Vallens <Vallens@Colorado.EDU>
From: Kevyn Shortell <kevyn@apple.com>
Subject: Re: The New iMac
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So there seems to be alot of confusion regarding chipsets, roms and such.

Here's a basic rundown.

NewWorld = The ROM Architecture used in ALL iMac's, B&W's, G4's and the Power
	   Book G3 1999 models. NewWorld is not an interface, it is not a new
            motherboard design, it is the boot ROM used by your computer to
            load the operating system.

UMA = Universal Motherboard Architrecture, which currently is used in
            iBook, iMac, and G4 Machines (Excluding the 400). This is an
            entirely new motherboard design.

Uni-North = The Uni-North memory controller and bus bridge IC combines
            the memory controller, the PCI bus bridge, the Ethernet
            interface, and the AGP port into a single IC.

Key-Largo = The KeyLargo is an integrated I/O controller and DMA engine
             for use in Power Macintosh computers with a PCI bus.
             The KeyLargo IC provides support for the Ultra ATA bus, USB,
             Sound IC, Power Controller, and AirPort card.


If you'd like to learn more about Apple hardware, please feel free to
take a look at http://developer.apple.com/techpubs/hardware/hardware.html,
which is our Hardware Developer Documentation section of our web site.

Thanks.

Kevyn


At 3:39 PM -0600 10/11/99, Alex Vallens wrote:
>It looks as though the real question is does it work on the iBook. The
>only significant addition to the new iMacs is the "New World" interface.
>This, if I remember correctly, posed some problems this summer when we
>tried to boot one of the iMacs at Macworld off the Linux CD. Has anyone
>messed around with booting an iBook with the Linux kernel? If this
>obstacle can be leaped, I'm sure the iMac will be easily booted also.
>
>What about the G4's? Anyone seen one of those Sawtooth machines, (not
>the Yikes!, since Yikes! is still the G3 architecture with a G4 slapped
>on)? All three of these have "New World" ROMs, so getting one to work
>should be enough to get all to boot.
>
>Alex
>

---------------------------------------------------------------
Kevyn Shortell                    Worldwide Developer Relations
Technology Manager          	  Apple Computer, Inc
kevyn@apple.com                   http://developer.apple.com/
"War doesn't determine who's right. War determines who's left"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
