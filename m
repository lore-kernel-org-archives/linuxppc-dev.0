Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7AF0DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 22:29:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HrCR8-0002NG-QQ
	for linuxppc-dev@ozlabs.org; Thu, 24 May 2007 05:28:58 -0700
Message-ID: <10782781.post@talk.nabble.com>
Date: Thu, 24 May 2007 05:28:58 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: adding new flash for jffs2 file system
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
View this message in context: http://www.nabble.com/adding-new-flash-for-jffs2-file-system-tf3809788.html#a10782781
Sent from the linuxppc-dev mailing list archive at Nabble.com.
