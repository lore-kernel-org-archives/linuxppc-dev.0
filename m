Message-ID: <20000222083924.6809.qmail@web204.mail.yahoo.com>
Date: Tue, 22 Feb 2000 00:39:24 -0800 (PST)
From: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
Subject: Boot process - Crash in serial_init fonction
To: embedded linuxppc <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

When going through the fonction serial_init of the
bootloader, I access to the address FA100000 but it
doesn't correspond to anything in our mapping.
So the program stops.
But for a MBX board this correspond to MBX status/
control registers.
My board is customize so I don't have this.
Do you think I will modify serial_init source code?
I've found this fonction in m8xxtty.c and in mbxtty.c

The mapping of our memory is the following one:

RAM     0        to   7FFFFFF
FLASH   8000000  to   803FFFF
IMMR    FF000000

I've seen that for MBX board the mapping for FLASH
starts at FE000000 and for IMMR at FA200000.
Should I use this?

Thank you in advance.

Sebastien ARTICLAUX


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
