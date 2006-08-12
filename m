Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC0EE67BBD
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:44:29 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k7C0iNLo006783
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 04:44:24 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 0/2] [Incomplete]POWERPC: Add mpc8272ads support to
	arch/powerpc
Date: Sat, 12 Aug 2006 04:37:59 +0400
To: linuxppc-dev@ozlabs.org
Message-Id: <20060812003759.6748.89145.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the current state of the PQ2/CPM2 powerpc merge approach. Assuming that all 
the 8560 and subsequent overhaul patches are applied. Despite of fact that  the code needs 
massive cleanup, and not 100% complete (PCI is under construction now), it may be used as 
reference by the other people who interested in moving some HW on a similar SoC to the powerpc.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely, Vitaly
