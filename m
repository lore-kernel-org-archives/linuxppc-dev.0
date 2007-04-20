Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E0A0DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Apr 2007 08:07:40 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1Hf1GS-0005rq-Da
	for linuxppc-embedded@ozlabs.org; Fri, 20 Apr 2007 15:07:36 -0700
Message-ID: <10111122.post@talk.nabble.com>
Date: Fri, 20 Apr 2007 15:07:36 -0700 (PDT)
From: RonLee <rlee@osii.com>
To: linuxppc-embedded@ozlabs.org
Subject: mpc5200 linux 2.4 wakeup interrupt problem
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


Hello,
 
I am running linux on a mpc5200 chip and Im having problems with the
mpc5200's simple and wakeup interrupts.  The version of Linux I am starting
with is linuxppc_2_4_devel_1_0_0 from Denx.  Modifications have been made to
the kernel, but none for enabling the wakeup register set and/or the wakeup
interrupts.
 
Does a patch exist to enable this behavior?  Can anyone point me in the
right direction if I would like to enable the wakeup interrupts myself?
 
I noticed the behavior when attempting to write a device driver to interface
with the psc1_4 pin on the mpc5200 chip.  I am able to get the chip to
generate interrupts, but when the interrupts occur I get the following error
message in /proc/kmsg "Unhandled interrupt c, disabled".  After getting this
error, I installed an interrupt handler on IRQ 12 (hex c).  This caused the
kernel to lock up.
 
Thanks for any help,
-Ron


-- 
View this message in context: http://www.nabble.com/mpc5200-linux-2.4-wakeup-interrupt-problem-tf3620873.html#a10111122
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
