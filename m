Date: Wed, 8 Jan 2003 10:23:23 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000
In-Reply-To: <885489B3B89FB6449F93E525DF78777F064531@srvnt506.ALLOPTIC.COM>
Message-ID: <Pine.LNX.4.40.0301081016070.6069-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 7 Jan 2003, Muaddi, Cecilia wrote:

> I have a proven hardware platform with
> 	PPC860, IMMR is mapped to 0xf0000000.
> 	16 MB of SRAM in CS3 starts at physical locatio 0x0
> 	1 MB of BootROM in CS1 starts at physical location 0x28000000
> 	16 MB of code flash in CS5 starts at physical location 0x08000000
> 	some other IO mapped to miscellaneous addresses.
>
> The hardware platform is running vxWorks with vxWorks bootrom.  I am trying
> to
> port the Linux to this custom hardware platform.  I was successful building

I'm sorry for sounding a bit negative and not giving any real help,
but I can't resist commenting that being able to run vxWorks is NOT
proving the same HW can also run Linux. This is because Linux is using
the HW in ways WindRiver can only dream vxWorks could. We have seen
many HW going down on it's knees in the transition from a boot-loader/
interrupt handler kind of OS to real Unix systems with true virtual
memory support.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
