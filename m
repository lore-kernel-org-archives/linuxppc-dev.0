Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 5A92FB6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:20 +1000 (EST)
Subject: [PATCH 0/8] ipi and irq cleanups and fixes
From: Milton Miller <miltonm@bga.com>
Message-Id: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:17 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are a few cleanups and fies mostly around the previous series
and a few more as I continue to explore exporting the irq_host concept
for other architectures.

milton
