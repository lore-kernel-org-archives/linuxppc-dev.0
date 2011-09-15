Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DBC8EB70C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Sep 2011 23:21:17 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] RapidIO: documentation update
Date: Thu, 15 Sep 2011 09:19:19 -0400
Message-Id: <1316092759-5460-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Liu Gang <Gang.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update rapidio.txt to reflect changes from recent patch.
See http://marc.info/?l=linux-kernel&m=131285620113589&w=2 for details.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Liu Gang <Gang.Liu@freescale.com>
---
 Documentation/rapidio/rapidio.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/rapidio/rapidio.txt b/Documentation/rapidio/rapidio.txt
index be70ee1..c75694b 100644
--- a/Documentation/rapidio/rapidio.txt
+++ b/Documentation/rapidio/rapidio.txt
@@ -144,7 +144,7 @@ and the default device ID in order to access the device on the active port.
 
 After the host has completed enumeration of the entire network it releases
 devices by clearing device ID locks (calls rio_clear_locks()). For each endpoint
-in the system, it sets the Master Enable bit in the Port General Control CSR
+in the system, it sets the Discovered bit in the Port General Control CSR
 to indicate that enumeration is completed and agents are allowed to execute
 passive discovery of the network.
 
-- 
1.7.6
