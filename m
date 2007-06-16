Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B2732DDFDC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:09:12 +1000 (EST)
Message-Id: <200706160209.07891.arnd@arndb.de>
Date: Sat, 16 Jun 2007 02:09:07 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 0/9] CPU selection Kconfig cleanup, take 4
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This time, I've removed all the changes that allow you to build
multiplatform kernels for the 8xxx embedded CPUs since Kumar
was not sure about those. Patch 9/9 still contains the patches,
but you can easily leave that one out.

What's left in patches 1-8 is basically

1. The selection of -mcpu and -mtune flags for all CPUs, which
should provide better optimized code in many cases, as well as
avoiding bugs that happen when the tool chain is built to default
to a different CPU.

2. All fixes for the bugs that I found in the process of making
multiplatform builds work for 6xx and e500.

        Arnd <><
