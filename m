Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044341@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Wolfgang Denk'" <wd@denx.de>,
        Brian Kuschak
	 <brian.kuschak@skystream.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Abatron BDI2000 
Date: Tue, 30 Jan 2001 16:37:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I reflashed my BDI2000 (loader=1.03, firmware=1.01, logic=1.01).
Unfortunately I get the same results.  I will contact Abatron.  Perhaps
there is a bug in this version of the command parser.

Thanks,
Brian


-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Tuesday, January 30, 2001 4:14 PM
To: Brian Kuschak
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Abatron BDI2000


In message <B25E2E5A003CD311B61E00902778AF2A0204433C@SERVER1> you wrote:
>
> Is anyone out there using the Abatron BDI2000 to set hardware breakpoints
on
> data access (on 405GP)? I'm probably just doing something dumb, but I
don't
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
