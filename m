Message-Id: <200011061234.eA6CYXd00907@denx.local.net>
To: ASchreckenberg@dspace.de
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Debugger Problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Nov 2000 12:53:58 +0100."
             <3A069BD6.9F63FF6C@dspace.de>
Date: Mon, 06 Nov 2000 13:34:33 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A069BD6.9F63FF6C@dspace.de> Andreas Schreckenberg wrote:
>
> Our board contains a MPC750-466 MHz CPU, it's no embedded system in the

Why not? You can build an Embedded System around any CPU :-)

> There is no firmware. The board has flash memory and jumps directly to
> ram after reset.
> Can I use ppcboot for my board ?

Yes, sure. You will have to make some modifications,  of  course.  So
far nobody ported it to a 750 board yet.

> I thought it's only for special TQM8xx boards.

No. We have support for several MPX8xx and  IBM  40x  based  systems:
TQM823L,  TQM850L, TQM855L, TQM860L, ETX094, ADCIOP, CPCI405, COGENT,
FADS, SPD823TS, FPS850L, MBX, SM850,  IVMS8.  There  are  some  other
systems,  where  I  have received success reports from the developers
who ported PPCBoot to their systems, but I never received patches.

Ports for MPC82xx systems are in the works.

> Perhaps I have read not enough about ppcboot... :-)

Definitely :-)

> I want to build a kernel and boot via ramdisk support, the board communicates
> with a serial port.

That's fine. You could use the serial port to download a Linux kernel
image (using S-Records and/or kermit binary protocol).

> I want to download my code via JTAG/BDM as a raw binary or elf file in the ram memory.
> (there are problems with elf and EST, because the EST debugger handles
> the kernel and ramdisk sections not correct, bin2bin which I found in
> the mailinglist seems to fix this for .bin files.)
> Finally all the stuff should be burned into flash.

That's fine. Just get working tools.

> I turn on the MMU and jump via an rfi instruction.
> (first init the srr0/srr1 registers) then the debugger confuses this situation
> and shows wrong code in the disassemby window.
>
> Is there any workaround availible ?
> Or is there no chance to use the EST Debugger with virtual memory ?

Sorry, I can't help here. We didn't buy this device  exactly  because
of this problem (and because of the price).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Unix is simple, but it takes a genius to understand the simplicity."
					             - Dennis Ritchie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
