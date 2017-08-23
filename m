Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn55Kz1zDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/46] powerpc/configs: Update for
 CONFIG_NF_CT_PROTO_(SCTP|UDPLITE)=y
Date: Wed, 23 Aug 2017 15:37:28 +1000
Message-Id: <1503466686-10932-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit a85406afeb3e ("netfilter: conntrack: built-in support for
SCTP"), NF_CT_PROTO_SCTP switched from tristate to bool and became
default y. Similarly in commit 9b91c96c5d1f ("netfilter: conntrack:
built-in support for UDPlite"), NF_CT_PROTO_UDPLITE switched from
tristate to bool and became default y.

We had a few configs which set them to =m, which is no longer valid.
We don't need to change them to =y because both symbols are default y
and are enabled automatically based on the other symbols in the
affected defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/linkstation_defconfig | 1 -
 arch/powerpc/configs/mvme5100_defconfig    | 1 -
 arch/powerpc/configs/ppc6xx_defconfig      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 8f5cd4d0e80b..477794c41d50 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_PROTO_SCTP=m
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 960a30c1d0c8..63e38c7220f1 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -35,7 +35,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_PROTO_SCTP=m
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 5d8fa80d7add..bad3e04163d0 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -140,7 +140,6 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_UDPLITE=m
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
-- 
2.7.4
