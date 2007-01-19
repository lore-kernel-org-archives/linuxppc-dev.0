Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by ozlabs.org (Postfix) with ESMTP id C888FDDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 19:29:55 +1100 (EST)
Received: from [192.168.0.2] (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp8-g19.free.fr (Postfix) with ESMTP id E28A35532
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 09:29:53 +0100 (CET)
Subject: Kernel 2.6.18.1 start hangs after Now Bootin the Kernel
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 19 Jan 2007 10:29:45 +0100
Message-Id: <1169198985.14340.4.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hy all,

I've colmpiled Linux 2.6.18.1 for ML403 and the start hangs after 

loaded at:     00400000 0050E13C
board data at: FFFFFFFF 00000017
relocated to:  004040A0 004040B8
zimage at:     00404E25 0050B014
avail ram:     0050F000 00FFF7FF

Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2 rw
Uncompressing Linux...done.
Now booting the kernel


The board data at: look very strange 

Any Idea?

Note :
 Board ML403
 Processor : ppc405
 Xilinx toolchain : EDK 8.2.02
 Hard Design : from scratch UART16550, TEMAC (V3), Sysace, DDR 32M, BRAM
16k, GPIO

Any help would be greatly appreciated.

Kinds regards

Chris
