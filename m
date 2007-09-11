Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA3B6DDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 04:05:21 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IVA6w-0007FQ-Pd
	for linuxppc-dev@ozlabs.org; Tue, 11 Sep 2007 11:05:18 -0700
Message-ID: <12620437.post@talk.nabble.com>
Date: Tue, 11 Sep 2007 11:05:18 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.23-rc3 is not booting
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,
I am using the kernel 2.6.23-rc3, when i try to boot the kernel i got
following messages. 

Booting image at 00200000 ...
   Image Name:   Linux-2.6.23-rc3
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1487259 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x600000.

        I have tested with and without pci express support in the kernel and
the device tree. But the result was same.

Processor information :

8641D processor and the silicon revision is 2.0.
Part : MPC8641D
Revision:  2.0
e600 Core Revision:  2.2
DeviceMarking:  B
Processor Version Register Value: 0x8004_0202
System Version Register Value:   0x8090_0120 

                     Please Advice me.
by
Sivaji
-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-is-not-booting-tf4424317.html#a12620437
Sent from the linuxppc-dev mailing list archive at Nabble.com.
