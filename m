Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05FDE@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Marius Groeger'" <mag@sysgo.de>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000
Date: Wed, 8 Jan 2003 08:59:00 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Do you have ppcboot ... or an equivalent bootloader running yet ?

If not start with this ...

Jim

-----Original Message-----
From: Marius Groeger [mailto:mag@sysgo.de]
Sent: Wednesday, January 08, 2003 4:23 AM
To: Muaddi, Cecilia
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: BDI-2000

On Tue, 7 Jan 2003, Muaddi, Cecilia wrote:

> I have a proven hardware platform with
> 	PPC860, IMMR is mapped to 0xf0000000.
> 	16 MB of SRAM in CS3 starts at physical locatio 0x0
> 	1 MB of BootROM in CS1 starts at physical location 0x28000000
> 	16 MB of code flash in CS5 starts at physical location 0x08000000
> 	some other IO mapped to miscellaneous addresses.
>
> The hardware platform is running vxWorks with vxWorks bootrom. I am
> trying to port the Linux to this custom hardware platform. I was
> successful building

I'm sorry for sounding a bit negative and not giving any real help,
but I can't resist commenting that being able to run vxWorks is NOT
proving the same HW can also run Linux. This is because Linux is using
the HW in ways WindRiver can only dream vxWorks could. We have seen
many HW going down on it's knees in the transition from a boot-loader/
interrupt handler kind of OS to real Unix systems with true virtual
memory support.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
