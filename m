Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: boot linux on a MPC8266ADS board
Date: Wed,  9 Apr 2003 12:13:57 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1049883237.12439.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I 've installed PPCBOOT1.2 (eldk2.0), it runs OK.
Now I have generate a kernel Linux2.4.4, so I follow these steps:
->in the file /linux-2.4.4/include/asm-ppc/mpc8260ads/mpc8260ads.h
I add:   #include <asm/ppcboot.h> /*as I read on the forum*/
         #define PHY_INTERRUPT 25
         #define IMAP_ADDR 0x04700000
->make config
->make dep
->make pImage

->Then with my ppcboot, I load the kernel, and the ramdisk(simple ramdisk).
->I try to run the kernel: and print "Uncompressing OK..."
"Transferring OK..." and it hangs.

I know some people had this problem. And you said that the bd structure had to be the same as defined in the ppcboot.
So you advice to put "#include <asm/ppcboot.h>" in /linux-2.4.4/include/asm-ppc/mpc8260ads/mpc8260ads.h

The file /linux-2.4.4/include/asm-ppc/ppcboot.h have in the bd struct definition a line "mon_fnc_t *bi_mon_fnv".

So if someone has a solution to this problem, please tell me.
thanks.

Nota: PPCBOOT is very fine!

greggiraud@netcourrier.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
