To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Lin,     Nan-Hung" <carl@fiberlogic.com>
Subject: Re: ramdisk problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "13 Jun 2002 15:20:00 -0000."
             <20020613152000.18777.qmail@webmail22.rediffmail.com>
Date: Thu, 13 Jun 2002 17:35:03 +0200
Message-Id: <20020613153508.249C0102F9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020613152000.18777.qmail@webmail22.rediffmail.com> you wrote:
>
>       i use kernel provided bootloader to load image,

This is not what I mean. You must have some sort of firmware  running
on  this board. Obviously it is not PPCBoot, because then things were
very simple.

There are firmware implementations which can  load  ELF  images,  but
either  load only "conventional" segments (text, data) or those which
have the "LOAD" flag set. The "zImage.initrd"  contains  non-standard
segments  ("image"  and  "initrd"),  which don't have the "LOAD" flag
set. Maybe your firmware does not load all segments...

>   i am using binary form of zImage
>   i didnt get u denk ,i dont know abt this elf what u have said ,i
> am not sure abt it ,i will check it

Maybe reading the "Linux for PowerPC Embedded Systems HOWTO" gives
some additional information, see
http://penguinppc.org/embedded/howto/PowerPC-Embedded-HOWTO.html

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not simplify the design of a program if a way can be found to make
it complex and wonderful.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
