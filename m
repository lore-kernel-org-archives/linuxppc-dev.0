Date: Mon, 25 Oct 1999 23:57:09 -0500
From: chris mccraw <chrism@brahma.ticam.utexas.edu>
Message-Id: <199910260457.XAA34718@brahma.ticam.utexas.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: IR on lombard?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi folks,

i've got a 333mhz g3 powerbook on which i'd dearly love to get serial-IR
working.  that is to say, use of the IR port like a serial port so that i
can talk to it with a palmpilot which is IR equipped.

the modem (on ttyS0) works a-ok...

this functionality seems to have been present or at least touched on for
the wallstreet powerbooks judging from the code in
	drivers/macintosh/macserial.c
but my (weak) attempts to force the second serial port into the role of
wallstreet powerbook_ir seem to have failed.

i did get the kernel to print "(powerbook IR)" next to the serial port init
by forcing zss->is_pwbk_ir to "1" in macserial.c (around line 2270)
but with no effect on the actual performance of the port.

turning on serial debugging shows that performing operations on /dev/ttyS1
seem successful (the port is opened, speed set, etc) but it doesn't answer
the pilot (as an x86 laptop with serial-IR did), nor show any actual
traffic over the port when i send it a few bits from the pilot.

i'm also not even sure that the second serial port detected on boot is
in fact the IR port...that's just a guess i cannot confirm or deny
after reading all the info i could find on the paddington and the pbg3-1999
on apple's site.

i am working with 2.2.13 from paul's tree synced this afternoon.

so, does anyone know if serial/IR is supposed to work on the lombards, or
have further suggestions for me to poke at it with?

much in your debt,

chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
