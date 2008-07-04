Return-Path: <lorenzo@alphagolf.com>
Received: from fallback-mx3.atl.registeredsite.com
	(fallback-mx3.atl.registeredsite.com [64.224.219.97])
	by ozlabs.org (Postfix) with ESMTP id 9AC7FDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 11:45:04 +1000 (EST)
Received: from mail29.atl.registeredsite.com (mail29.atl.registeredsite.com
	[216.247.37.24])
	by fallback-mx3.atl.registeredsite.com (8.12.11.20060308/8.12.11) with
	ESMTP id m64194x9012638
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Jul 2008 21:09:05 -0400
Received: from imta08a2.registeredsite.com (imta08a2.registeredsite.com
	[64.225.255.17])
	by mail29.atl.registeredsite.com (8.12.11.20060308/8.12.11) with ESMTP
	id m6418uja010971
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Jul 2008 21:08:56 -0400
Received: from daniellap.ag.com ([67.180.142.109])
	by imta08a2.registeredsite.com with ESMTP id
	<20080704010851.XJEU1923.imta08a2.registeredsite.com@daniellap.ag.com>
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Jul 2008 21:08:51 -0400
Message-ID: <486D774A.7000102@alphagolf.com>
Date: Thu, 03 Jul 2008 18:05:14 -0700
From: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: booting an ML405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey all,

I did a little preliminary poking through the thread archives, but 
didn't turn anything up. I anyone could just point me in the right 
direction as far as troubleshooting, that would be great!

I'm trying to compile the Xilinx patched kernel tree (v2.6.25-rc9) and 
run it on an ML405

So far, I get to the following point in the boot sequence:

loaded at:     00400000 005AF5A0
board data at: 005AD524 005AD5A0
relocated to:  00405058 004050D4
zimage at:     00405E90 0051D6CC
initrd at:     0051E000 005ACC0D
avail ram:     005B0000 80000000

Linux/PPC load: console=ttyS0,9600 ip=on root=/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel

The system hangs after it says "Now booting the kernel."

Once again, any input would be appreciated.

thank you,
Lorenzo
