Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1334DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:18:24 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IVg9l-0001VV-Hz
	for linuxppc-dev@ozlabs.org; Wed, 12 Sep 2007 21:18:21 -0700
Message-ID: <12648489.post@talk.nabble.com>
Date: Wed, 12 Sep 2007 21:18:21 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.23-rc3 boot hang on MPC8641D
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
        I am try to boot the 2.6.23-rc3 kernel to my custom board based on
8641D Processor. After uncompressing the kernel it was hang. I got the
following messages.

   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x600000. 

       Then i tried to debug with GDB. In my source path i given the command
${CROSS_COMPILE}gdb vmlinux, I got GDB Prompt after i tried to set the
breakpoint at start_kernel. I got follwing messages

gdb) b start_kernel
Cannot access memory at address 0xc02b44ec

Processor Information:
8641D processor and the silicon revision is 2.0.
Part : MPC8641D
Revision:  2.0
e600 Core Revision:  2.2
DeviceMarking:  B
Processor Version Register Value: 0x8004_0202
System Version Register Value:   0x8090_0120

     I don't know how to proceed. Please tell the way how to start kernel
debug in this situation.

By
Sivaji
-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648489
Sent from the linuxppc-dev mailing list archive at Nabble.com.
