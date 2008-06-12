Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A354DE2C1
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:40:41 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] Kill CONFIG_PPC_CPM_NEW_BINDING
Date: Thu, 12 Jun 2008 08:40:29 -0500
Message-Id: <1213278034-28552-1-git-send-email-galak@kernel.crashing.org>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With arch/ppc gone we can get rid of CONFIG_PPC_CPM_NEW_BINDING.  These
should be pretty trivial.

These will go via my powerpc-next tree if no one has issues.

- k
