Message-Id: <200208130028.g7D0SN916108@panix3.panix.com>
Subject: Looking for IBM Fire Coral PCI/ISA bridge information
To: linuxppc-embedded@lists.linuxppc.org
Date: Mon, 12 Aug 2002 20:28:23 -0400 (EDT)
From: "Jochen Roth" <jochen@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am bringing up 2.4.19 on an older 603ev platform, using the
IBM 27-82660 host bridge and a PCI/ISA bridge identified by
the kernel pci name database as 'IBM Fire Coral (rev 3)'.

I have pdf files for the 82660 bridge chip set from the IBM
web site, but I have not found any data on the PCI/ISA bridge.
The PCI ID is vendor=0x1014, device=0x000A.

Some more information:

init-2.04# cat /proc/pci
PCI devices found:
  Bus  0, device  11, function  0:
    ISA bridge: IBM Fire Coral (rev 3).
      I/O at 0x100040 [0x100047].
  Bus  0, device  12, function  0:
[...]

init-2.04# hexdump /proc/bus/pci/00/0b.0
0000000 1410 0a00 4701 0004 0300 0106 0000 0000
0000010 4100 1000 0000 0000 0000 0000 0000 0000
0000020 0000 0000 0000 0000 0000 0000 0000 0000
0000030 0000 0000 0000 0000 0000 0000 ff00 0000
0000040 0000 0000 0000 0000 0000 0000 0000 0000
0000050 0001 0000 0000 0000 0000 0000 0000 0000
0000060 0000 0000 0000 0000 0000 0000 0000 0000
*
0000100

(The hexdump output is BE interpretation shorts of LE data.)

Looking at the circuit board I would assume that the PCI/ISA
bridge is in a chip with Texas Instruments markings. I don't
have the board in front of me right now, but I will look up
the markings if that helps identify the chip. Googling for
any of the strings and sub-strings did not yield anything...

Regards,
Jochen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
