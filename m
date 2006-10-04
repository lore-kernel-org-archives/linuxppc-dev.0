Return-Path: <steck.armin@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BA5FB67C55
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 19:04:26 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 04 Oct 2006 11:04:25 +0200
From: "Armin Steck" <steck.armin@gmx.de>
Message-ID: <20061004090425.57760@gmx.net>
MIME-Version: 1.0
Subject: uboot-1.1.4 linux-2.6.10: Image bootproblems
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

i have ported uboot1.1.4 for my board.
When i would like to boot linux-kernel-2.6.10 the system hang after decompressing.
can anybody help me? 

Flash: 0x00000000 uboot
       0x00020000 ubootenvironment
       0x00040000 kernel uImage

uImage: gzip -9 < zImage > Image.gz
	/elinux/kernel2.6Richard/Richard/linux-2.6.10/scripts/mkuboot.sh 
          -A arm -O linux -T kernel -C gzip -a 0xa0008000 -e 0xa0008000 -n
          'Linux-2.6.10' -d Image.gz uImage

U-BOOT output:
RAM Configuration:
Bank #0: a0000000 32 MB
Flash #0: 00000000 16 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot: 1
uboot==> bootm 0x00040000
## Booting image at 00040000 ...
   Image Name:   Linux-2.6.10
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    756009 Bytes = 738.3 kB
   Load Address: a0008000
   Entry Point:  a0008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Uncompressing Linux................................................... done, booting the kernel.

69052D06:0000001B:00001078          #Kernel-Debug-Information
A00DC914-A0259594>A0008000
A0259594


-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
