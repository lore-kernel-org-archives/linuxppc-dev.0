Message-ID: <3B375D00.FC56DFE9@aps.anl.gov>
Date: Mon, 25 Jun 2001 10:47:12 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME2100
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can't believe I'm the first person to want to run LinuxPPC on the
Motorola MVME2100 board, although there aren't many references to it in
the archives.  I have the HardHat Linux 2.0 Journeyman edition installed
for the 8240 CPU (we're thinking about buying the professional edition),
but I can see that the Motorola Sandpoint configuration (the nearest
target to the 2100) isn't going to work without some changes as there is
no SouthBridge on a 2100 (or else I really don't understand this
PPC/PCI/ISA architecture stuff yet, give me VME any day!).

While I'd like to hack together support for the 2100, it would seem a
waste if someone else has already done this - any offers?  Alternatively
any pointers to documentation on how to go about supporting a new board
would be welcome.

TiA,

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
