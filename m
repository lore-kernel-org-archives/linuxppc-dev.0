Message-ID: <021901c308f5$ebb456a0$50905943@LEIYINGDU>
From: "Leiying Du" <ldu@solectek.com>
To: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: GDB Load symbol file failed
Date: Tue, 22 Apr 2003 10:37:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to debug a device driver with BDI2000. The driver is compiled and
debugged with the development packages in the ELDK2.0. I have added -g -ggdb
in the kernel mode CFLAGS when compiling the driver. The Linux kernel
version is 2.2.13. I have followed the steps in Wolfgang's ELDK document to
load the symbol file. I used the 'add-symbol-file driver.o 0xXXXXXXXX',
where XXXXXXXX=.text and got an error message 'DWARF: There is no abbrev num
103'.
What could cause this problem? Should I check if the driver.o in the target
is stripped properly?
Thanks,

Bright Du


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
