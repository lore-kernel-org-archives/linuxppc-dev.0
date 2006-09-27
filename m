Return-Path: <hbausley@deltatau.com>
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211])
	by ozlabs.org (Postfix) with ESMTP id 38BE167A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 09:14:38 +1000 (EST)
Message-ID: <137d01c6e288$844fcdd0$8119fea9@deltatau.local>
From: "Henry Bausley" <hbausley@deltatau.com>
To: <linuxppc-embedded@ozlabs.org>
References: <HOECLKEKOHLAMMGDLLBHGEKJHLAA.stelios@stelioscellar.com>
Subject: Uncompressing Kernel Image ... Error: inflate() returned -3 GUNZIP
	ERROR - must RESET board to recover
Date: Wed, 27 Sep 2006 15:58:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am getting the error

Uncompressing Kernel Image ... Error: inflate() returned -3
GUNZIP ERROR - must RESET board to recover
OK

when u-boot tries to uncompress the kernel.  I am using a board based upon a 
Yosemite AMCC 440EP.
I do have some boards that work.  Does anyone know what could cause this 
problem.  Bad Flash , Bad DDR ?






U-Boot 1.1.4 (Jun 30 2006 - 14:55:59)

CPU:   AMCC PowerPC 440EP Rev. B at 533.333 MHz (PLB=133, OPB=66, EBC=66 
MHz)
       I2C boot EEPROM enabled
       Internal PCI arbiter disabled, PCI async ext clock used
       32 kB I-Cache 32 kB D-Cache
Board: Yosemite - AMCC PPC440EP Evaluation Board
I2C:   ready
DRAM:  256 MB
FLASH: 64 MB
PCI:   Bus Dev VenId DevId Class Int
In:    serial
Out:   serial
Err:   serial
Net:   ppc_4xx_eth0, ppc_4xx_eth1
Hit any key to stop autoboot:  0
## Booting image at fc000000 ...
   Image Name:   Linux-2.6.14-rtl
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1250069 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... Error: inflate() returned -3
GUNZIP ERROR - must RESET board to recover
OK
