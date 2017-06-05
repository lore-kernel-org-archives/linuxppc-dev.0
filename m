Return-Path: <dcaratti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whH9f6pLyzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 00:23:34 +1000 (AEST)
From: Davide Caratti <dcaratti@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/configs: fix default values for NF_CT_PROTO_*
Date: Mon,  5 Jun 2017 16:22:38 +0200
Message-Id: <eb1df478772aec9e4caa43f575df5579c1f4170a.1496668107.git.dcaratti@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NF_CT_PROTO_{SCTP,UDPLITE,DCCP} can't be set to 'm' anymore, since they
have been redefined as 'bool': fix defconfig for linkstation, mvme5100 and
ppc6xx platforms accordingly.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 arch/powerpc/configs/linkstation_defconfig | 2 +-
 arch/powerpc/configs/mvme5100_defconfig    | 2 +-
 arch/powerpc/configs/ppc6xx_defconfig      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index b413c19..d36d618 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -26,7 +26,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CT_PROTO_SCTP=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 139add9..265ccec 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -35,7 +35,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CT_PROTO_SCTP=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 18d0d60..bc8ff4b 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -141,7 +141,7 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
-- 
2.9.4
