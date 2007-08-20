Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3C72DDDD8
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 23:56:09 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7KDu4lm023424
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 08:56:05 -0500
Date: Mon, 20 Aug 2007 08:56:20 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3 v3] Remove need for include/asm-ppc
Message-ID: <Pine.LNX.4.64.0708200854160.16444@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series removes the need for include/asm-ppc in the ARCH=powerpc
build for ppc32.  They exist in the following git tree:

  master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

posting here for everyone else to see.

Updated to fix ans-lcd driver building, some hydra drivers that got broken
and the fact that mpc7448_hpcn.h still included ppcboot.h

- k
