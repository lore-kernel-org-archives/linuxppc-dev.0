Return-Path: <dhlii@picocomputing.net>
Received: from outbound-mail-02.bluehost.com (outbound-mail-02.bluehost.com
	[69.89.21.12]) by ozlabs.org (Postfix) with SMTP id 213B1DE168
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 04:41:19 +1000 (EST)
Received: from 70.15.107.162.res-cmts.eph.ptd.net ([70.15.107.162]
	helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <dhlii@picocomputing.net>)
	id 1Jojnh-00068R-MO
	for linuxppc-embedded@ozlabs.org; Wed, 23 Apr 2008 12:34:37 -0600
Message-ID: <480F8148.8090906@picocomputing.net>
Date: Wed, 23 Apr 2008 14:34:48 -0400
From: "David H. Lynch Jr." <dhlii@picocomputing.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: simpleboot
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    I am trying to decipher hot to use the simpleboot devicetree wrapper
and I am not grasping the process.

    I need an initramfs kernel, inside an elf wrapper.
    right now I get that pretty much for free.

    How do  ask for a simpleboot wrapper kernel ?
       It is a target for a makefile in arch/powerpc/boot how to I cause
that target to get invoked
      
    How does it choose the device tree to wrap ?

    How does it interact with things like initramfs ?




-- 
Dave Lynch                                          Pico Computing, Inc.
Software Development                                      Embedded Linux
717.627.3770      dhlii@picocomputing.net   http://www.picocomputing.com
fax: 1.253.369.9244                                 Cell: 1.717.587.7774
Tiny Mighty Machines
