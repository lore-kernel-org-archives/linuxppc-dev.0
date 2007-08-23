Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30473DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 23:36:31 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IOCrL-0000sW-Ua
	for linuxppc-embedded@ozlabs.org; Thu, 23 Aug 2007 06:36:27 -0700
Message-ID: <12293748.post@talk.nabble.com>
Date: Thu, 23 Aug 2007 06:36:27 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Flash paritioning and JFFS2
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


Dear All,

     I am running linux 2.6.21 (by Grant) on the ppc405 which is build in
Virtex-4 of Avnet (xlinx ml403 like) evaluation board. The Avnet board has
the 4 MB of  NOR Flash (Intel TE28F640) . I just wanted to make use of the
Flash to store
u-boot, linux kernel and some config files.

To do so I wanted first to partition Flash to three partitions:
- U-Boot
- Linux-kernel
- JFFS2 (for some config files)

Could someone advice me how to configure Linux kernel to make use of the
Flash (with above mentioned partitions and JFFS2.

The information which I have collected is as following that I have to:
enable in kernel:
Device Drivers->Memory Technology Devices (MTD)
File Systems -> Miscellaneous file systems -> JFFS2

I do not know however which specific options to enable for MTD/JFFS2 since
it has many sub options.
I do not no also where to place:

-the partition information (which I have mentioned above) 
-the start (0xFF800000) and end (0xFFBFFFFF) physical location of my Flash
memory.

My aim is to mount (after booting Linux) the JFFS2 partition to store some
config data.

Best Regards and thank you in advance for any hint on that

Mirek 
   

 
-- 
View this message in context: http://www.nabble.com/Flash-paritioning-and-JFFS2-tf4317566.html#a12293748
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
