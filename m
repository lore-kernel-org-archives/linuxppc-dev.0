Return-Path: <eddie@embeddedarm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3005FB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 03:15:23 +1000 (EST)
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 5753EDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 03:15:22 +1000 (EST)
Message-ID: <4A6DDF80.209@embeddedarm.com>
Date: Mon, 27 Jul 2009 10:10:24 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: image/wrapper script questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm working on a custom board using an AMCC 440EP that is using a proprietary 
bootloader(optimized for fast boot time). Currently our bootloader loads a 
simpleImage.initrd into RAM and jumps into it. I originally chose to use a 
simpleImage with an initial ramdisk embedded because it was the simplest 
solution to debug the hardware and get a kernel and initial ramdisk running for 
development. For production I would prefer to put the initial ramdisk on it's 
own partition to allow customers to easily modify the initrd without having to 
concern themselves with the details of how to recompile a kernel. Would you 
recommend using one of the existing images(e.g. boot wrapper) or modify the 
bootrom to load the PPC registers with the details of where to find the dts, 
kernel, and initrd?

Thanks for any suggestions :)

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive              | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
