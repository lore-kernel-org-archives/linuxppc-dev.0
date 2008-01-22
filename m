Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72969DDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:36:08 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JHRis-0005cX-Nq
	for linuxppc-dev@ozlabs.org; Tue, 22 Jan 2008 16:36:04 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3 v3] Add StorCenter port
Date: Tue, 22 Jan 2008 16:36:02 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JHRis-0005cX-Nq@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar,

Here is the StorCenter port with the MTD partitions
re-written to be hard-coded PHYSMAP partitions for now.

Please pick up for 2.6.25!

Thanks,
jdl

 arch/powerpc/boot/Makefile                      |    3 +-
 arch/powerpc/boot/cuboot-824x.c                 |   53 +
 arch/powerpc/boot/dts/storcenter.dts            |  139 +++
 arch/powerpc/configs/storcenter_defconfig       | 1174 +++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/Kconfig      |   23 +-
 arch/powerpc/platforms/embedded6xx/Makefile     |    1 +
 arch/powerpc/platforms/embedded6xx/storcenter.c |  188 ++++
 7 files changed, 1574 insertions(+), 7 deletions(-)
