Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DCBDADE02E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 23:23:44 +1000 (EST)
Date: Tue, 3 Apr 2007 23:24:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] [SPARC/64] Make device_node name and type const
Message-Id: <20070403232406.ab9a3c86.sfr@canb.auug.org.au>
In-Reply-To: <20070403230505.f96ea210.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-sparc/prom.h   |    4 ++--
 include/asm-sparc64/prom.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

This produces no new warnings or errors for a sparc64 allmodconfig build.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 030461d..c239a80 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -35,8 +35,8 @@ struct property {
 };
 
 struct device_node {
-	char	*name;
-	char	*type;
+	const char	*name;
+	const char	*type;
 	phandle	node;
 	char	*path_component_name;
 	char	*full_name;
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index dd0a6cd..88e62cc 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -36,8 +36,8 @@ struct property {
 
 struct of_irq_controller;
 struct device_node {
-	char	*name;
-	char	*type;
+	const char	*name;
+	const char	*type;
 	phandle	node;
 	char	*path_component_name;
 	char	*full_name;
-- 
1.5.0.3
