Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200312061024.EAA19753@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Can not see any infomation on the console when using U-Boot 1.0.0 booting my board 
Mime-Version: 1.0
Content-Type: text/plain
Date: Sat, 6 Dec 2003 18:32:20 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
   I am now porting U-Boot 1.0.0 to my custumized board with mpc8240.
My reference board is Sandpoint X2.
   First I created my u-boot.bin for Sandpoint X2 as following:
   $make Sandpoint8240_config
   $make all
and Sandpoint X2 was booted smoothly.
   Then I modified the serial port information in
~~/u-boot1.0.0/include/configs/sandpoint8240.h because the serial port
address on my board is different from that on Sandpoint X2. Below are my
modification:

#define CFG_NS16550_CLK		24000000 /* 1843200 */

#define CFG_NS16550_COM1	0xff600000 /*(CFG_ISA_IO + CFG_NS87308_UART1_BASE)*/
#define CFG_NS16550_COM2	0xff600040 /*(CFG_ISA_IO + CFG_NS87308_UART2_BASE)*/

Other parameters are not modified.

 	After "make" and "burn u-boot.bin in flash" I reset my board
and I saw nothing on my console:(
	Any suggestion? Thanks in advance.

Yuxiao Xi
2003-12-06

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
