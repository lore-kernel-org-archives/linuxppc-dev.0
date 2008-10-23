Return-Path: <arieswar24b@yahoo.de>
Received: from web25808.mail.ukl.yahoo.com (web25808.mail.ukl.yahoo.com
	[217.12.10.193]) by ozlabs.org (Postfix) with SMTP id 73AE6DDDD4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 00:06:51 +1100 (EST)
Date: Thu, 23 Oct 2008 13:00:09 +0000 (GMT)
From: Dave Best <arieswar24b@yahoo.de>
Subject: Using Bestcomm API (DMA) on MPC5200b with Linux?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <406316.49476.qm@web25808.mail.ukl.yahoo.com>
Reply-To: arieswar24b@yahoo.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to connect a FPGA/FIFO with my MPC5200b on a phytec PCM 030 boa=
rd  while running a 2.6.23.1 Linux.

The Linux Kernel source contains an implementation for the Bestcomm API in =
the form of a driver for ethernet (fec) and ATA.(situated in the arch-power=
pc/sysdev/bestcomm path) I tried to make use of it but i've run into some p=
roblems.

So i tried to include the API in a module to utilize its functionality but =
no luck till now.

Freescale supports the Bestcomm DMA API not on an OS level. So the problem =
is adopting this API into a Linux environment, which distinguishes between =
kernel space and user space while writing to the appropriate registers.

Further information is very hard to find for such a common task as starting=
 a DMA transfer.

Dave
=0A=0A=0A      
