To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 26 Jun 2001 13:18:04 +0200
From: "karanth karanth" <karanthk@lycos.com>
Message-ID: <BEOODLLCEMKDDCAA@mailcity.com>
Mime-Version: 1.0
Reply-To: karanthk@lycos.com
Subject: Uncompressing......
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hai,

Iam using mpc823, Iam able to load the compressed image at 0x00200000, iam trying to boot through NFS it shows the following message,

Boot

loaded at	: 00000000 	000141B4
board data at	: 00202344	00202374
zimage at	: 0038A000	0007E0B1
avail ram		: 002141B4	0038A000

Linux/PPC load: console=ttyS0, 19200n8!

Uncompressing Linux...done
hold_residual=00600100
Now booting the kernel

after showing this message it reboot again and search for the server. The out put of the objdump -h

arch/ppc/boot/zvmlinux:     file format elf32-powerpc


Sections:

Idx Name          Size      VMA       LMA       File off  Algn

 0 .text         000073b4  00200000  00200000  00010000  2**2

		CONTENTS, ALLOC, LOAD, READONLY, CODE

 1 .rodata       00000560  002073c0  002073c0  000173c0  2**4

                CONTENTS, ALLOC, LOAD, READONLY, DATA

 2 .data         00000314  00208000  00208000  00018000  2**2

                 CONTENTS, ALLOC, LOAD, DATA

 3 .bss      0000c05c  00209000  00209000  00019000  2**2

              ALLOC

 4 image         00076602  00000000  00000000  00019000  2**0

              CONTENTS, READONLY


can any help out to figure the problem.
Thanking You,
kk




Get 250 color business cards for FREE!
http://businesscards.lycos.com/vp/fastpath/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
