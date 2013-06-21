Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDF8B2C02F7
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Jun 2013 18:37:00 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 21 Jun 2013 18:22:37 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 060B62BB0050
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Jun 2013 18:36:53 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5L8LwF866715834
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Jun 2013 18:21:59 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5L8aoJn028606
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Jun 2013 18:36:51 +1000
Subject: [PATCH] powerpc/pseries: Enable PSTORE in pseries_defconfig
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 21 Jun 2013 14:06:47 +0530
Message-ID: <20130621083639.4039.27789.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable PSTORE in pseries_defconfig

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/configs/pseries_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index c4dfbaf..9630a50 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -347,3 +347,4 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=y
 CONFIG_VHOST_NET=m
+CONFIG_PSTORE=y
