Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id A74B8DE007
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jun 2008 19:31:36 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K60CR-0003wL-L1
	for linuxppc-embedded@ozlabs.org; Tue, 10 Jun 2008 02:31:31 -0700
Message-ID: <17751311.post@talk.nabble.com>
Date: Tue, 10 Jun 2008 02:31:31 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem in flashing of yaffs image.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ...

I am facing problem in flashing yaffs image(yaffs not yaffs2). The problem
is this :-

I am able to create the yaffs image but when i do 

./mkyaffs -e /dev/mtd8 image_name.img

It is giving ioctl MEMSETOOB error ....

Commenting this ioctl call does Erase the flash but not Writing 
when i try to mount .... mount -t yaffs /dev/mtd8 /mnt 

Its not showing the contents ....where in other files i could be able to
write to the mtdblock usinf flash erase and write commands 


Could any one share their thought or experience regarding this problem 
-- 
View this message in context: http://www.nabble.com/Problem-in-flashing-of-yaffs-image.-tp17751311p17751311.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
