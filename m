Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.101.113.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1D08067A78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 01:39:09 +1100 (EST)
Received: from wip-ectls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6068B2200E3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 19:56:22 +0530 (IST)
Received: from blr-ec-bh1.wipro.com (blr-ec-bh1.wipro.com [10.200.50.91])
	by wip-ectls-mx1.wipro.com (Postfix) with ESMTP id 54BBC220003
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 19:56:22 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 14 Feb 2005 19:55:35 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA5A1@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Our target is somewhat like this. It has PPC8270, Flash and SDRAM. We
are using the uboot for booting. Successfully built the linux kernel and
Ramdisk images using devrocket. The problem is that the kernel and
Ramdisk images although getting extracted successfully to 0M location of
SDRAM from Flash with the help of uboot, the serial console says nothing
except "uboot ist nicht tot..."

The command used is bootm "kernelImageLocation in Flash" "RAMdisk Image
in Flash"

i.e bootm 0xfe080000 0xff080000


1. How do I know that the control was given to linux kernel?

2. Is it that the linux kernel got the control but unable to put the
prompt on the serial line? FYI.  I modified the inittab to reflect the
console to come on the serial line.

3. Is there any documentation which gives the detailed debugging of the
linux kernel from the loading of kernel?


-Thanks=0D
SS




Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
