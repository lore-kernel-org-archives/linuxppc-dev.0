Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D13E967B2D
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:52:38 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1Frjec-0004Oc-Ou
	for linuxppc-dev@ozlabs.org; Sat, 17 Jun 2006 17:52:35 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/9 v3] Introduce the MPC8641 HPCN platform
Date: Sat, 17 Jun 2006 17:52:34 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Frjec-0004Oc-Ou@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is the third posting of a series of patches
that introduces the MPC8641 HPCN platform.  This
version corrects all of the suggestions from Kumar,
and shows an ACK from Jeff Garzik for the netdev
related parts.  It also addresses all of the problems
that Ben brought up related to multi-platform issues.
It does not use IRQ settings from the device tree yet;
that will come as a follow on patch when Ben's IRQ
rewrite is more solid.

Please consider this for addition into the 2.6.18 queue.

Collectively:

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Jeff Brown <Jeff.Brown@freescale.com>
Signed-off-by: Kriston Carson <KristonCarson@freescale.com>
Acked-by: Jeff Garzik <jeff@garzik.org>
