Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32BDA2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 03:47:27 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 12 Sep 2012 11:47:24 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 28E0919D803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 11:47:21 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8CHlHKh139546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 11:47:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8CHlEu2006846
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 11:47:14 -0600
Date: Wed, 12 Sep 2012 10:47:07 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] pseries: double NR_CPUS in defconfig
Message-ID: <20120912174706.GE9269@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anticipating growth in coming years, we should ensure we are getting a
good lead on testing.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 1f65b3c..a0e0e53 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -2,7 +2,7 @@ CONFIG_PPC64=y
 CONFIG_ALTIVEC=y
 CONFIG_VSX=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=1024
+CONFIG_NR_CPUS=2048
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
