Date: Thu, 21 Feb 02 10:52:14 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0202211852.AA06721@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: More StarMON bits salvaged
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

I've salvaged a few more StarMON-related bits from my ex-SBS files (should that
be X-Files? :) that aren't SBS-specific and therefore can go into the IFCTF CVS
repo. These are ETHDI0, the diagnostic utility for Intel 8255x PCI Ethernet
chips, including EEPROM programming, and FDPUA0, the utility for Am29LV040B
flash in-system programming. Check them out with:

cvs -d :pserver:anoncvs@ivan.Harhan.ORG:/fs3/IFCTF-cvs co ppcstar-diags

Have fun!

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
