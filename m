Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC62BDDE35
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 04:54:19 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JBwAx-0006Il-CE
	for linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 11:54:16 -0600
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 0/3]: Add StorCenter port to arch/powerpc
Date: Mon, 07 Jan 2008 11:54:15 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JBwAx-0006Il-CE@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I have the bulk of a port for the iomega StorCenter that
Andy and I have been working on.  We'd like your feedback!

Specifically, it's not quite working yet, and for lack of
actually getting serial output, we're having some difficulty
still.  I post it here in a desperate attempt to let some
eagle-eyed person point out my obvious "D'oh" problem.

Thanks,
jdl


 arch/powerpc/boot/Makefile                      |    3 +-
 arch/powerpc/boot/cuboot-824x.c                 |   52 +
 arch/powerpc/boot/dts/storcenter.dts            |  159 +++
 arch/powerpc/configs/storcenter_defconfig       | 1538 +++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/Kconfig      |   15 +-
 arch/powerpc/platforms/embedded6xx/Makefile     |    2 +
 arch/powerpc/platforms/embedded6xx/storcenter.c |  158 +++
 7 files changed, 1924 insertions(+), 3 deletions(-)
