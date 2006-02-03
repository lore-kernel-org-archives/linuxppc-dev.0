Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id E58CE68A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 07:45:45 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k13KjhtT010781
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 12:45:43 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k13KjhSC027420
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 12:45:43 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gdb with MPC85xx
Date: Fri, 3 Feb 2006 12:46:24 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201AC366C@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <fabidi@ultsol.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

To the best of my knowledge, I had could single step but not run to a
breakpoint in the initial u-boot code on PPC8540( an E500 core based)
system
Esp. in the code in start.S.  I had a problem where the flash was busted
and
The start.S was running from a DDR2 memory at 600+MHz rate.  So, I had
to lock the TLB and define LAW for the DDR memory in BDI so that we
could run entire u-boot, kernel, ramdisk from RAM. =20

It seemed like a BDI bug to me unless the processor is designed to
always boot from a slow deviceflash or eeprom) till the initialization
sequence is=20
Completed.  Did not try extensive debug with it, so not sure. If it
helps.

--
Atul
-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Fahd Abidi
Sent: Friday, February 03, 2006 10:41 AM
To: linuxppc-embedded@ozlabs.org
Subject: Gdb with MPC85xx

Hello,

I am wondering if someone here is using GDB to debug code on an 85xx
platform with the BDI. I have been running into several issues with GDB
5.x and 6.x where the E500 core does not seem to either step properly to
the next line of code in the kernel or uboot or gets lost altogether.
Each version of GDB seems to have its own set of bugs. If someone has
been using a version of GDB that works pretty well then let me know what
version it is and I can try and download it and build it and see if it
behaves better.

This is probably more of a tools question then a Linux question, I'm
hoping I can get an answer anyway.

Thanks,

Fahd
=20
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
