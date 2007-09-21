Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0A3DDDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:03:22 +1000 (EST)
Date: Fri, 21 Sep 2007 18:02:51 -0500 (CDT)
Subject: [PATCH 0/15] bootwrapper: kexec and external payloads
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series of 15 patches implement 

	support for 64-bit powerpc zImage to be loaded by kexec-tools
		the wrapper uses the same startup interface as the kernel

	support for obtaining the kernel externally to the zImage link
		including via searching for a path string in initramfs

This is the third round of posting for most of the patches, which
have been rebased to apply to for-2.6.24, and I ask they be considered
for inclusion therein.

I have ordered the series to apply needed functionality to get
usable code for similar enviornments before fleshing out the feature
set I am using.  If desired I can reorder and rediff as requested.
(for example, adding the smp hook could go with the smp marshalling
support).  The last patch is only needed for the qemu pathes below.

Following the series are an additonal 2 patches to provide experimental
platform support for running under qemu with its exiting powerpc
prep emulation.  One patch provides the support necessary to build
the kernel, the second patch provides the wrapper changes and device
tree to boot, including bulding a "rom" image.  Once the rom is
built, it can start a vmlinux elf when loaded into memory by qemu.

Thanks for your consideration,
milton
