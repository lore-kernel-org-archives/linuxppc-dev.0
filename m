To: Andres Chamorro Morillas <achamorro@prodys.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 onchip WatchDog 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 07 Mar 2002 00:56:35 +0100."
             <3C86ACB3.C7445E95@prodys.net>
Date: Wed, 06 Mar 2002 23:19:44 +0100
Message-Id: <20020306221949.E3916109EB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C86ACB3.C7445E95@prodys.net> you wrote:
>
> Hi, I trying to use the MPC860 onchip WatchDog.I compile ppcboot-1.1.4
> with include/config_MBX.h ( I have a MBX860 board) I compile the
> linux-2.4.4-2002-02-14 kernel by denx. I activate the WatchDog support

Remember that you have to build a PPCBoot image (i. e. either run the
mkimage tool manually, or type "make pImage" ...).

> MPC860.Well, I make tftpboot then I tray to boot the
> kernel but...
> Loading .text @ 0x00180000 (23052 bytes)
> Loading .rodata @ 0x00185a10 (2320 bytes)
> Loading .data @ 0x00187000 (808bytes)
> Loading __ex_table @ 0x00187328 (24 bytes)
> ## Starting application at 0x00180000...
> loaded at:  00210000 0021B59C
> relocated to:  00180000 0018B59C
> board data at: 043A0288 043A02BC
> relocated to:  00200100 00200134
> zimage at:  00218000 002A95D8
> avail ram:  002AA000 04400000
> Linux/PPC load:root=/dev/nfs rw
> Uncompressing Linux...done.
> Now booting the kernel

This is NOT a PPCBoot image booting! Make sure you read the README file.

> And reset.
> Thats mean that WD works fine but I can't boot.
> What can I do???

RTFM.

> Modify the kernel code to service the watchdog????

No need to moify anything. The driver is already included  with  that
version of the kernel sources. You have to enable it, though.

> Which part of kernel I have to modify???

Nothing.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A fanatic is a person who can't change his mind and won't change  the
subject.                                          - Winston Churchill

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
