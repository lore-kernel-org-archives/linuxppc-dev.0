Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50CCFDDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 01:11:58 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I3Chv-0001jL-MB
	for linuxppc-embedded@ozlabs.org; Tue, 26 Jun 2007 08:11:55 -0700
Message-ID: <11307459.post@talk.nabble.com>
Date: Tue, 26 Jun 2007 08:11:55 -0700 (PDT)
From: sarpa <vsarpangala@satline.net>
To: linuxppc-embedded@ozlabs.org
Subject: zImage on mpc5200
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


I am building the Linux kernel target "zImage.elf" in PPC branch of Linux
Kernel 2.6.16.11 and then converting it to zImage.bin using OBJCOPY so that
i can flash it to my PPC based target using BDI. i am currently facing
issues in booting this kernel using my own bootloader(i am not using
u-boot). Before I flood mailing list with more detailed questions I just
wish to know if the standalone kernel image type zImage.elf is know to work
in Linux kernel 2.6.16.11 or not ? Has anyone ever tested standalone
zImage.elf on PPC ? Note that I am able to boot uImage using U-boot for this
kernel but now I am trying to use my own Bootloader to boot zImage.elf "
-- 
View this message in context: http://www.nabble.com/zImage-on-mpc5200-tf3982933.html#a11307459
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
