Message-ID: <006001c28989$fb0922c0$0564a8c0@Obelix>
Reply-To: "Andreas Beranek" <a.beranek@cci.isar.de>
From: "Andreas Beranek" <a.beranek@cci.isar.de>
To: "Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>
Cc: "Linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com> <3DCF5E9B.406F7565@bmrtech.com> <1037020322.22840.70.camel@spawn>
Subject: Re: gdbserver and gdb cross debug?
Date: Mon, 11 Nov 2002 14:55:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

> > I am porting Linux on EP405 board. So I use gdbserver and gdb......

> Has anybody tried the bdi2000 is that also broken now ? ....

We encountered similar problems. We got it to work with the BDI2000.

Some hints:

Use the latest Firmware from Abatron.
Use the latest Tools and Kernel.
Set the Breakpoint-type to "HARD" in BDI config file.
Check the MMU setup.
Avoid setting software breakpoints in FLASH.

Mit freundlichen Grüßen,

Andreas Beranek

*
* CC&I Computer Communication & Interface GmbH
* Starnbergerstrasse 22
* D-82131 Gauting
* Germany
*
* Tel.:  xx49 (0)89 850 97 18
* Fax:   xx49 (0)89 850 97 19
* Email: a.beranek@cci.isar.de
* Web:   www.cc-i.com
* --... ...-- -.. . -.. .-.. ..--- -- .. -.-.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
