Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 8BD3E67BB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 19:40:16 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC] Current Lite5200b patchset
Date: Wed,  1 Nov 2006 01:39:49 -0700
Message-Id: <11623703962380-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain;

As promised, here's the patchset that I'm currently working on for the
Lite5200.  This depends on Nicolas' pic patch.  Right now I've got the
kernel booting w/ log output upto trying to run init.

You'll also need to get the lite5200 device tree patch for u-boot off the
u-boot-users mailing list, and the device tree compiler from www.jdl.com.

Device tree is compiled w/:
$ dtc -V 0x10 -f -O dtb arch/powerpc/boot/dts/lite5200b.dts > lite5200b.dtb

When you boot the kernel, use 'bootm <kernel> <initrd> <dtb>'
