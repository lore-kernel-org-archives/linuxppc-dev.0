Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A669FB703B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 01:32:10 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 14 May 2012 21:02:06 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4EFW3w411403584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2012 21:02:03 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4EL2Wh9024573
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2012 07:02:32 +1000
Message-ID: <4FB12570.9090503@linux.vnet.ibm.com>
Date: Mon, 14 May 2012 21:02:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Fixing a cputhread code documentation
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index ce516e5..ac3eedb 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -9,7 +9,7 @@
  * Note: This implementation is limited to a power of 2 number of
  * threads per core and the same number for each core in the system
  * (though it would work if some processors had less threads as long
- * as the CPU numbers are still allocated, just not brought offline).
+ * as the CPU numbers are still allocated, just not brought online).
  *
  * However, the API allows for a different implementation in the future
  * if needed, as long as you only use the functions and not the variables

--
Anshuman Khandual
