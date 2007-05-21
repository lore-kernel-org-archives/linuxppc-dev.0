Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DE3EDDE25
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 15:45:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Hq0Q2-0006DA-0N
	for linuxppc-dev@ozlabs.org; Sun, 20 May 2007 22:26:54 -0700
Message-ID: <10713345.post@talk.nabble.com>
Date: Sun, 20 May 2007 22:26:53 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: linux support for am29lv641ml
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


hi,

I have tested jffs2 booting on board MPC8272ADS and PQ2FADS-ZU board.
linux is 2.6.10 and boot loarder is u-boot-1.1.2.
Now we r using custom board simillar to MPC8272ADS board...
but flash we r using here is AM29LV641ML.But jffs2 booting is not working.

does kernel has support for this flash..?, if not how to add the support for
this flash?

with regards,
Nethra.
-- 
View this message in context: http://www.nabble.com/linux-support-for-am29lv641ml-tf3788347.html#a10713345
Sent from the linuxppc-dev mailing list archive at Nabble.com.
