Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17A11DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:05:43 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0I05euV008393
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:05:40 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-199.am.freescale.net
	[10.214.72.199])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0I05dK7028206
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 18:05:39 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCHES v3 0/8] 
Date: Thu, 17 Jan 2008 17:05:30 -0700
Message-Id: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a new improved set of patches based on the
comments that I received in response to the previous set.

Changes since v2:

1/8 Add-IPIC-config-option.patch
2/8 Add-mpc512x-ipic-support.patch
    No changes.  These two are in galak's queue for submission.

3/8 Basic-Freescale-MPC512x-support.patch
    Added missing of_put_node as pointed out by Stephen Rothwell
    Added Acked-by: Grant Likely <grant.likely@secretlab.ca>

4/8 Device-tree-for-MPC5121-ADS.patch
    Made changes suggested by Grant Likely

5/8 Separate-MPC52xx-PSC-FIFO-registers-from-rest-of-PSC.patch
6/8 Cleanup-checkpatch.pl-problems-in-mpc52xx_uart.c.patch
    No changes.  Grant is picking up these patches

7/8 Factor-out-52xx-dependencies-from-52xx-psc-driver.patch
    No changes.  No comments received.  Too ugly to comment?

8/8 Add-MPC512x-support-to-MPC52xx-psc-driver.patch
    Added IRQF_SHARED to flags passed to request_irq because
    on 5121 all PSCs use the same irq.  This should not break
    anything on 5200.
