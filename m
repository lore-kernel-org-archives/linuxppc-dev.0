Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 51CBCDDE23
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 08:04:11 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LrfsO-0008GF-Ss
	for linuxppc-dev@ozlabs.org; Wed, 08 Apr 2009 15:04:08 -0700
Message-ID: <22960621.post@talk.nabble.com>
Date: Wed, 8 Apr 2009 15:04:08 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Xilinx board and NPTL support lockup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi everyone,

I have a board similar to the ml410, its been running a linux kernel happily
for about a year now, but now the firmware guys want NPTL threading instead
of the linuxthread library.
I recompiled my gcc 4.0.2 and glibc 2.3.6 library with the NPTL support, and
recompiled my kernel with the new tools.

Now my kernel gets stuck at the infamous "Now Booting the Kernel" message.

Any thoughts on why this might be happening, or how to verify that my glibc
and gcc are functional other than trying to compile things with them (I know
this works).

Thanks
Kevin 
-- 
View this message in context: http://www.nabble.com/Xilinx-board-and-NPTL-support-lockup-tp22960621p22960621.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
