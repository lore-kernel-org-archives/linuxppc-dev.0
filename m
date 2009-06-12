Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB83DB719E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 10:04:48 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 534EADDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 10:04:48 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Jun 2009 02:04:20 +0200
Message-Id: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 0/2] add OF wrapper for uio-pdrv-genirq
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds an OF wrapper for the uio-pdrv-genirq driver.

Patch 1 refactors the platform driver to expose a generic probe-routine.
Patch 2 then adds the OF wrapper. Documentation for the binding is also added.
        There may be an issue with stack-usage, as noted there.

Tested on MPC5200B-based custom boards with 2.6.30.

(Note: this is not meant for the current merge window.)

Thanks,

   Wolfram
