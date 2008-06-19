Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 133B6DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jun 2008 02:33:11 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K9N4N-0006SR-0u
	for linuxppc-embedded@ozlabs.org; Thu, 19 Jun 2008 09:33:07 -0700
Message-ID: <18012972.post@talk.nabble.com>
Date: Thu, 19 Jun 2008 09:33:07 -0700 (PDT)
From: swamydp <swamydp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: linux 2.6 hangs at __delay function on Viretx 4 board
In-Reply-To: <17222725.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <17222725.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello 

Sorry for the late reply. I was busy with another project.

I finally got linux 2.6 to boot on HITECH board. 

Thanks to John Linn for all the pointers to debug the code. I also got the
UARTLITE as console working. I had to disable several macros in
virtex_devices.c to make the kernel boot.

Now I am working on using UART16550 as console which is free at Xilinx after
registration. Thanks to Marc and Stephen for the info.

--swamy



swamydp wrote:
> 
> 
> I am trying to boot linux 2.6 on HITECH virtex 4(fx60) board. Linux hangs
> at address 0xc00045ec which is in the __udelay function. I am using EDK
> 9.2i and gcc version 4.0.2 for compiling the kernel. The following is the
> boot message from the bootloader. 
> 
> loaded at:     00400000 0054E19C
> board data at: 0054C120 0054C19C
> relocated to:  00404064 004040E0
> zimage at:     00404E55 0054B5B4
> avail ram:     0054F000 02000000
> 
> Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
> Uncompressing Linux...done.
> Now booting the kernel
> 
> Any help is greatly appreciated. I have run out of ideas to fix this.
> 
> Thanks
> swamy
> 
> 

-- 
View this message in context: http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-board-tp17222725p18012972.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
