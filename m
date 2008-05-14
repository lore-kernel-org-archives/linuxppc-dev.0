Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 957C3DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 13:29:07 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Jw7fs-0003Ni-26
	for linuxppc-embedded@ozlabs.org; Tue, 13 May 2008 20:29:04 -0700
Message-ID: <17222725.post@talk.nabble.com>
Date: Tue, 13 May 2008 20:29:04 -0700 (PDT)
From: swamydp <swamydp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: linux 2.6 hangs at __delay function on Viretx 4 board
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



I am trying to boot linux 2.6 on HITECH virtex 4(fx60) board. Linux hangs at
address 0xc00045ec which is in the __udelay function. I am using EDK 9.2i
and gcc version 4.0.2 for compiling the kernel. The following is the boot
message from the bootloader. 

loaded at:     00400000 0054E19C
board data at: 0054C120 0054C19C
relocated to:  00404064 004040E0
zimage at:     00404E55 0054B5B4
avail ram:     0054F000 02000000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel

Any help is greatly appreciated. I have run out of ideas to fix this.

Thanks
swamy

-- 
View this message in context: http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-board-tp17222725p17222725.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
