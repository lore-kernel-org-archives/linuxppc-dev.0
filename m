Return-Path: <huangyun@coship.com>
Received: from pub.guangzhou.gd.cn (pub.forptr.21cn.com [61.140.60.62])
	by ozlabs.org (Postfix) with ESMTP id BAAE9DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 20:40:26 +1000 (EST)
Received: from [58.61.30.6] (pupaisp4.inner-21cn.com [10.2.104.4])
	by pub.guangzhou.gd.cn (HERMES) with ESMTP id 28209162A2B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 19:21:46 +0800 (CST)
Received: from dmserver.coship.com by [58.61.30.6] (MDaemon PRO v9.5.1)
	with ESMTP id md50001231346.msg
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 18:32:31 +0800
Subject: booting linux-2.6.15 hang on custom mpc8555 board
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF7929EEAE.73E06DAF-ON48257306.0036AB63-48257306.0039FAD3@coship.com>
From: huangyun@coship.com
Date: Tue, 26 Jun 2007 18:33:41 +0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi,everyone
   I have porting linux2.6.15 of eldk4.0 to my mpc8555 board, my bootloader
is u-boot1.1.6, the uboot running is ok,but it hang at booting kernel.no
any print message.
I have check the CCSRBAR(0xe0000000) and bd_t struct is the  same as linux
kernel,  my serial port use uart1. somebody help me! i'm a linux kernel
newer.
   there is some booting information:

CPU:   8555, Version: 1.1, (0x80790011)
Core:  E500, Version: 2.0, (0x80200020)
Clock Configuration:
       CPU: 660 MHz, CCB: 330
       DDR: 165 MHz, LBC:  82 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: IP
    PCI1: 32 bit, 66 MHz (compiled)
I2C:   ready
DRAM:  Initializing
    DDR: 256 MB
before relocate_code
FLASH:
the first flash SST39VF040 size:  512 KB
the second flash MX29LV640MBTC size:  8 MB
the third flash MX29LV640MBTC size:  8 MB
Total Flash capacity: 16.5 MB
L2 cache 256KB: enabled
*** Warning - bad CRC, using default environment

leave the env
enter into getenv
leave getenv
In:    serial
Out:   serial
Err:   serial
Net:
TSEC0, TSEC1
Hit any key to stop autoboot:  0
Waiting for PHY auto negotiation to complete. done
Speed: 1000, full duplex
Using TSEC0 device
TFTP from server 192.168.96.110; our IP address is 192.168.96.168
Filename 'uImage'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         ##################
done
Bytes transferred = 1088988 (109ddc hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.15
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1088924 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ...OK
