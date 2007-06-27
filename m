Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE6A9DDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 02:40:10 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I3aYp-0004bL-22
	for linuxppc-embedded@ozlabs.org; Wed, 27 Jun 2007 09:40:07 -0700
Message-ID: <11328063.post@talk.nabble.com>
Date: Wed, 27 Jun 2007 09:40:05 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Porting Linux to Xilinx ML410
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Im trying to get linux 2.6 to run on my ML410 board from xilinx.  I just
created a real simple system with a Uartlite DDR2 and DDR interupt
controller and sysace.  I installed the patches I found for Uartlite and
sysace I found here.  I boot the zImage with XMD with the following
commands:
dow t:/zImage.elf
con
This is what I get out the serial port:
loaded at:     00400000 00537138
board data at: 00000000 00000018
relocated to:  00404064 0040407C
zimage at:     00404E6D 005345F1
avail ram:     00538000 7C7F1B78

Linux/PPC load: console=ttyUL0,9600 root=/dev/xsysace/disc0/part3 rw
Uncompressing Linux...done.
Now booting the kernel

It always stall on the Now booting the kernel.  Im new to linux building and
any help or suggestions are greatly appreciated.
Thanks
Kevin
-- 
View this message in context: http://www.nabble.com/Porting-Linux-to-Xilinx-ML410-tf3989483.html#a11328063
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
