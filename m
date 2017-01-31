Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCTQH67wGzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 01:38:15 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0VEY06b103333
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:38:13 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28audnu46c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:38:13 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 00:38:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 804A33578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 01:38:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0VEc03W24510676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 01:38:08 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0VEbaRQ010827
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 01:37:36 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: enable UPROBE_EVENT in defconfigs
Date: Tue, 31 Jan 2017 20:07:12 +0530
Message-Id: <39bf4b52484efc4f4b31303450a528ad260ab0ad.1485872578.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable UPROBE_EVENT in ppc64, pseries and powernv defconfigs since this
is very useful to have by default.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/configs/powernv_defconfig | 1 +
 arch/powerpc/configs/ppc64_defconfig   | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index e4d53fe5976a..8e2b1da2560e 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -319,3 +319,4 @@ CONFIG_CRYPTO_DEV_VMX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
+CONFIG_UPROBE_EVENT=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 0396126ba6a8..270fbfe61ab6 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -360,3 +360,4 @@ CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_POWERNV=m
+CONFIG_UPROBE_EVENT=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 5a06bdde1674..bd9246588596 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -323,3 +323,4 @@ CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_POWERNV=m
+CONFIG_UPROBE_EVENT=y
-- 
2.11.0
