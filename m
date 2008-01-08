Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90886DDFB4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 09:05:44 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JCMZn-0002lk-NW
	for linuxppc-dev@ozlabs.org; Tue, 08 Jan 2008 16:05:40 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3 v2] Add iomega StorCenter basic port
Date: Tue, 08 Jan 2008 16:05:39 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JCMZn-0002lk-NW@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

Here's the second pass at the patches to add the basic
iomega StorCenter port to arch/powerpc.  This version
of the patches addresses the comments from the first
round, cleaning up the Kconfig, DTS and board file.

Thanks,
jdl

 arch/powerpc/boot/Makefile                      |    3 +-
 arch/powerpc/boot/cuboot-824x.c                 |   52 +
 arch/powerpc/boot/dts/storcenter.dts            |  155 +++
 arch/powerpc/configs/storcenter_defconfig       | 1174 +++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/Kconfig      |   23 +-
 arch/powerpc/platforms/embedded6xx/Makefile     |    1 +
 arch/powerpc/platforms/embedded6xx/storcenter.c |  165 ++++
 7 files changed, 1566 insertions(+), 7 deletions(-)
