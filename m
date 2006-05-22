Return-Path: <nreddy@netenrich.com>
Received: from mail.netenrich.com (mail.netenrich.com [204.13.82.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F934679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 22:20:08 +1000 (EST)
Message-ID: <45530.61.95.208.2.1148300461.squirrel@61.95.208.2>
Date: Mon, 22 May 2006 05:21:01 -0700 (PDT)
Subject: "How to change the Magic number"
From: nreddy@netenrich.com
To: u-boot-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi ALL,

 I have a specific requirement to change the Magic number of the linux
kernel in my embedded system.

 I cound see the Magic number is defined in U-boot files:
 1.include/image.h:#define IH_MAGIC        0x27051956
 2.cpu/ppc4xx/start.S:     .long   0x27051956

  So i can modify in u-boot to make it compatible to my Kernel (i am using
montavista linux version 2.4.20), but i am not able to see this kindof
info anywhere in the kernel source files.
If anyone knows how the linux magic number is generated and what are the
files
 need modifications inorder to change magic number please let me know.


Thnaks in Advance,
Nagi
