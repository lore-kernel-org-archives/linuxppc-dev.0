Message-ID: <002a01c1b9b6$d5f25720$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Dustin Byford" <dustin@firein.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20020218214414.69EE4109E2@denx.denx.de> <auto-000008693306@zipmail.com>
Subject: Re: custom mpc8240 student project (long)
Date: Tue, 19 Feb 2002 21:32:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Or: Leave the EEPROM on RCS0 all the time.  The AMD Flash on RCS1 all the
> time and find another place to put the UART.  Suggestions?
>

The removable device is a good idea.  Once you get the process down,
you should be able to build an image, program it into the part, install the
part on the board and boot it.  Make that image a serial loader that can
program the other flash part if you must, or just run from the EEPROM
during development.

I agree with Jerry, JTAG is horribly slow and your time would be spent
more wisely on a serial loader or the end application.  I have written a
couple of JTAG loaders that operate on the PC serial port using a
Xilinx Parallel III cable.  The last one requried 12 minutes to program
40Kb into flash.  We use that as a last resort to load a blank board
with a serial loader.

Greg Griffes


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
