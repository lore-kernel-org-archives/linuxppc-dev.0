Message-Id: <200101310013.f0V0DdS14226@denx.local.net>
To: Brian Kuschak <brian.kuschak@skystream.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Abatron BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Jan 2001 14:42:00 PST."
             <B25E2E5A003CD311B61E00902778AF2A0204433C@SERVER1>
Date: Wed, 31 Jan 2001 01:13:39 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B25E2E5A003CD311B61E00902778AF2A0204433C@SERVER1> you wrote:
>
> Is anyone out there using the Abatron BDI2000 to set hardware breakpoints on
> data access (on 405GP)? I'm probably just doing something dumb, but I don't
> see it. Any ideas?

Not on 405, but on 8xx / 82xx instead.

> BDI>bd w 0xc019c390
> # syntax is BDx [R|W]

BDI>bd w 0xc019c390
Breakpoint identification is 0

Works fine for me.

> BDI>bdx w 0xc019c390
> # syntax error in command

Error, "bdx" is no valid command.

> BDI>bd w c019c390
> # syntax error in command

Error, c0... is no valid hex number (0x... missing).

> BDI>bd 0xc019c390
> # syntax is BDx [R|W]

BDI>bd 0xc019c390
Breakpoint identification is 1

Works fine for me.

Um... Try re-loading the firmware.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
