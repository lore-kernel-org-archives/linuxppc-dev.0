To: jtm@smoothsmoothie.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Feb 2001 23:18:31 CST."
             <20010221231831.A19177@shamus.smoothsmoothie.com>
Date: Thu, 22 Feb 2001 09:23:13 +0100
Message-Id: <20010222082318.71ACE281D9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010221231831.A19177@shamus.smoothsmoothie.com> Jay Monkman wrote:
>
> I've been trying to get Linux going on an 8260 board (EST's SBC8260 eval
> board to be exact) and I have ppcboot starting the kernel. ppcboot sets
> up SMC1 at 9600 bps as its console, and when Linux starts up, it
> starts running SMC1 at 115200 bps. How do I make Linux keep SMC1
> at 9600 bps?

It  seems  you  forgot  to  modify   the   "bd_info"   structure   in
"include/asm-ppc/est8260.h""  to  match  the  definition as passed by
PPCBoot.

Read the PPCBoot README, too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No journaling file system can recover your data if the disk dies.
                                 - Steve Rago in <D4Cw1p.L9E@plc.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
