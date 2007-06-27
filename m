Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AF3BDDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:16 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l5RIJCO7006651
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 13:19:13 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] [POWERPC] PCI merge of ppc32 & ppc64
Date: Wed, 27 Jun 2007 13:19:10 -0500
Message-Id: <11829683583721-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a set of patches queued for 2.6.23 that merge some of the common
bits of ppc32 & ppc64 PCI code.

Also available at:

master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

- k
