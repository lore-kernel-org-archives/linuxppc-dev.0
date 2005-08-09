Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (unknown [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 9D5B667FBE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 04:58:53 +1000 (EST)
Received: from [192.168.180.201] ([132.250.144.104])
	by mail.theptrgroup.com (8.11.6/linuxconf) with ESMTP id j79IrW516574
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 Aug 2005 14:53:36 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 14:51:16 -0400
Message-Id: <1123613476.8354.27.camel@nighteyes.site>
Mime-Version: 1.0
Subject: MPC8260 - memcpy() vs IDMA
Reply-To: jeff@theptrgroup.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Does anybody have any real life numbers of the latency and/or throughput
associated with moving large amounts of data using the IDMA channels
rather than direct memcpy()?  Some information online suggests that the
IDMA is noticeably slower than the CPU memcpy() and that it does
significantly impact the other CPM functionality.  I guess the MPC860
was really bad in this regard but the MPC82xx was supposed to be much
better.  Is anybody using IDMA on their systems (besides the PCI9
workaround?)

FWIW, I am moving around 1 to 4MB/s of data from an FPGA to local memory
on a custom MPC8260 board.  


Thanks,
Jeff Angielski
The PTR Group
