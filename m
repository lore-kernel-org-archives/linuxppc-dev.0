Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0053.outbound.protection.outlook.com [104.47.32.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttpKx2swFzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:21:41 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] dpaa_eth: a couple of fixes
Date: Wed, 4 Jan 2017 13:21:28 +0200
Message-ID: <1483528890-8621-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add cleanup on PHY initialization failure path, avoid using
uninitialized memory at CGR init.

Madalin Bucur (1):
  dpaa_eth: cleanup after init_phy() failure

Roy Pledge (1):
  dpaa_eth: Initialize CGR structure before init

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.1.0
