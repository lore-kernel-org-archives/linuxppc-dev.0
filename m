To: Dustin Byford <dustin@firein.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: custom mpc8240 student project (long) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 18 Feb 2002 15:32:14 MST."
             <auto-000008693306@zipmail.com>
Date: Mon, 18 Feb 2002 23:32:56 +0100
Message-Id: <20020218223301.57292109E2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <auto-000008693306@zipmail.com> you wrote:
> I understand what you're saying about the COP so I need to evaluate my
> options.  We are all students working on this so I don't think my coleauges
> will spring for the BDI since we don't have one available to us at the
> University.  Is the BDI1000/2000 the least expensive way to use the JTAG/COP?

In terms of time AND money AND power: definitely.

> An alternate idea:  What if I jumper in a 32 pin PDIP 8-bit EEPROM somewhere
> that I can boot from (RCS0/8-bit).  I can pull this part off of the board and
> throw it in a programmer we have at the university.  Hopefully I'll be able
> to program it with something that will "simply" program itself onto the TSOP
> AMD flash (which would then be jumpered to (32-bit/RCS1).  Remove the jumpers
> and reset the board and maybe I would have a ROM that can downlaod stuff
> through the UART.  Not the quickest of development cycles but it is a no-cost
> solution.

OK, now you can program your boot device. You plug it in,  power  on,
and you are lucky: no magic smoke to be seen.

But your code doesn't run (and I guarantee you that it will  not  run
on first attempt).

I bet you'd like to have a debugger then...

> Or: Leave the EEPROM on RCS0 all the time.  The AMD Flash on RCS1 all the
> time and find another place to put the UART.  Suggestions?

Yes, two: find some working hardware which already has  the  firmware
running, or get yourself the neccesary tools.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
