Return-Path: <sailesh.panchal@matrixtelesol.com>
Received: from UrlSunMail2.dellwebserver.com (32.27.354a.static.theplanet.com
	[74.53.39.50]) by bilbo.ozlabs.org (Postfix) with ESMTP id 649D5B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 19:25:45 +1000 (EST)
From: "Shailesh Panchal" <Sailesh.Panchal@Matrixtelesol.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: ucc_geth.c - NETDEV WATCHDOG: eth2 Tx transmit timeout 
Date: Thu, 3 Sep 2009 14:43:44 +0530
Message-ID: <7CDA290E2BBB4E2C8FDBF69D355E61AC@DOMAIN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: 'Ronak Shah' <Ronak.Shah@Matrixtelesol.com>,
	'Shailesh Panchal' <Shailesh.Panchal@matrixtelesol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Dear All,

Currently we are using the MPC8360E processor, for that we face the problem
with Ethernet port (UCC) port, which one configures as RMII mode. We get the
error like "NETDEV WATCHDOG: eth2 tx transmit timeout", When applied more
load on port. Can u give me any solution for this problem; I will see the
entire patch related it but not found solution of this problem. Any one has
any idea about it how to resolve it.

Wait for Replay

Regards,
Shailesh
