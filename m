Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E316DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 22:51:06 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J9JAd-0003kA-8b
	for linuxppc-embedded@ozlabs.org; Mon, 31 Dec 2007 03:51:03 -0800
Message-ID: <14556782.post@talk.nabble.com>
Date: Mon, 31 Dec 2007 03:51:03 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: How to make a extern variable shared between two drivers.
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


Hi all ...

I need to know that How to make a variable accessible to two different
device drivers. One of the driver is a simulation driver which will write
the data to the variable and the other "actual driver" will read the data
from the variable.

The variable will be declared in the actual driver the simulation driver
will only write to it doing the work of the hardware component.

Please reply if anyone has tried this before or suggest me if you have an
idea to share .


-----Misbah <>< 
-- 
View this message in context: http://www.nabble.com/How-to-make-a-extern-variable-shared-between-two-drivers.-tp14556782p14556782.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
