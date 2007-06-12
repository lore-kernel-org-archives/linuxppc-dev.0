Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E1A39DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:39:21 +1000 (EST)
Message-Id: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:16 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 00/13] CPU selection Kconfig cleanup, take 3
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Next try:

I've removed the patch that moves CONFIG_PPC64 into the CPU selection
now, and split out the unrelated bug fix noticed by Stephen.

During testing, I found a few more bugs, for which I include patches
as well this time. Building without PCI support seems to be not well
tested in general.

I also had a few bug fixes to make 8xx build, but it became clear
that it's pretty pointless in the current code as there are too
many bugs in there. There is not even a single 8xx configuration
that can build in arch/powerpc, it should probably just be marked
as broken.

	Arnd <><
