Message-Id: <sb7bbbbe.017@mail.scires.com>
Date: Thu, 16 Aug 2001 12:25:04 -0400
From: "Doug Hubbard" <dhubbard@scires.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: BDM and gdb
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using the Macraigor Systems RAVEN bdm dongle and attempting, initially to just look at the processor registers.  I am using the test code and make file supplied by Macraigor.

First, (complaint) the connector on the bdm cable appears to have been installed backwards.  Someone noticed because they shaved the key of the connector.  When plugged correctly (pin 1 to pin 1) I get jtag/bdm errors, when plugged in backwards I get no download errors.

Once downloaded the program will not execute and when I poke around the processor registers they all show an address AND a value of 0x5015010.

I have tried this on 2 MBX boards and our custom board which uses the same MPC860 processor.

TIA.

¯ Doug

Doug Hubbard
Software Engineer
Scientific Research Corporation
2300 Windy Ridge Parkway
Suite 400, South
Atlanta, GA 30339

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
