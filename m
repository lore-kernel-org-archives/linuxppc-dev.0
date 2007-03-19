Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0402DDDF73
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:47 +1100 (EST)
Date: Mon, 19 Mar 2007 14:55:54 -0600 (CST)
Subject: [PATCH 0/7] boot: cleanup and prep for more platforms
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What follows are the first 7 of my 13 patch series working on a zImage
that kexec will boot to, at least on 64 bit boxes.

The first one makes the Makefile maintainable, the second and third
make the Makefile work correctly.  The forth is a cleanup for a 
common idiom, the fifth adds some missing relocations, and the
sixth and seventh allow other code to reuse the existing functions
after necessary setup.

All have been compile and link tested, and were created against
a 2.6.20 tree + the 20 patches I found related to the boot directory
in powerpc.git + patchwork numbers 10010 and 10012 (which seemed
to be moving that direction).  I have included additional notes
in some of the patches with the testing.  I think all could be
applied to for-2.6.22.

The last 4, that I am not posting at this time, build upon these
to create a zImage for use by 64-bit kexec, add a sreset based
derivative target, and allow for disjoint vmlinuz payloads.  I hope
to be able to find time in the near future to debug and post
them.

milton

boot-zImage-rule
boot-add-wrapper-to-wrapperbits
boot-add-FORCE
boot-add-fatal
boot-crt0-missing-reloc
boot-crt0-export
boot-export-flush-cache
