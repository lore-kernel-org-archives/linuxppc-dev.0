Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnN3C1bzDqm5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 41/46] powerpc/configs/6xx: Drop no longer needed
 CONFIG_NETFILTER_XT_MATCH_SOCKET
Date: Wed, 23 Aug 2017 15:38:01 +1000
Message-Id: <1503466686-10932-42-git-send-email-mpe@ellerman.id.au>
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

Since commit 8db4c5be88f6 ("netfilter: move socket lookup
infrastructure to nf_socket_ipv{4,6}.c") we no longer need to set
CONFIG_NETFILTER_XT_MATCH_SOCKET in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index de771d5e564a..40d81eb00202 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -185,7 +185,6 @@ CONFIG_NETFILTER_XT_MATCH_QUOTA=m
 CONFIG_NETFILTER_XT_MATCH_RATEEST=m
 CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_RECENT=m
-CONFIG_NETFILTER_XT_MATCH_SOCKET=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
-- 
2.7.4
