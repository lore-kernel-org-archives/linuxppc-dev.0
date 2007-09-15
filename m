Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B16FADDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 06:14:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IWe25-0000Lu-J3
	for linuxppc-embedded@ozlabs.org; Sat, 15 Sep 2007 13:14:25 -0700
Message-ID: <12693399.post@talk.nabble.com>
Date: Sat, 15 Sep 2007 13:14:25 -0700 (PDT)
From: jqhu <jqhu936@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: make menuconfig problem
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


I'm compiling kernel 2.6.22 downloaded from kernel.org.  When running "make
menuconfig", it says:
  scripts/kconfig/conf arch/ppc/Kconfig
  #
  # using defaults found in /boot/config-2.6.3-7mdksmp
  #

So by default it's using the config file in /boot directory, which is not
correct.
  
I checked the source directory and notice that there's no .config file
present.  Could anybody tell me what I should do on this?

Thanks!
-- 
View this message in context: http://www.nabble.com/make-menuconfig-problem-tf4448774.html#a12693399
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
