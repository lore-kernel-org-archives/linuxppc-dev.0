Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF851DE590
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:44:24 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/10] powerpc: Remove use of CONFIG_PPC_MERGE
Date: Fri,  1 Aug 2008 11:44:10 -0500
Message-Id: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This set of patches remove Kconfig and code related to CONFIG_PPC_MERGE
and !CONFIG_PPC_MERGE.  There is some discussion about that one last
use of !PPC_MERGE with respect to the 4xx MTD_NAND_NDFC driver.

Paul, is this something you'd be willing to entertain for 2.6.27?

- k
