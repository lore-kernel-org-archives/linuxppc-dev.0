To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 May 2001 19:19:07 +0200."
             <IGEFJKJNHJDCBKALBJLLGEDNENAA.joakim.tjernlund@lumentis.se>
Date: Thu, 10 May 2001 19:40:53 +0200
Message-Id: <20010510174058.CF2942814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <IGEFJKJNHJDCBKALBJLLGEDNENAA.joakim.tjernlund@lumentis.se> you wrote:
>
> I am trying to debug ppclinux 2.4 and ppcboot on RPX CLLF board
> connected to an Abatron emulator.

Did you invalidate the M_TWB in the BDI config file ("WSPR  796  0"),
and did you enable address translation ("MMU XLAT") ?

> When I print variables in gdb I get an <error type> message

And what was the EXACT error message?

> instead of the variable value. Breakpoints and stack trace etc. works
> fine. I have enabled -g switch to gcc.

Which version of GDB are you using, and which firmware version of the
BDI2000? (b20ppcgd.108 has been out for some time).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The typical page layout program is nothing more  than  an  electronic
light table for cutting and pasting documents.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
