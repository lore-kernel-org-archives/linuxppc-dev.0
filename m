Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 177C3DDE0C
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 17:26:21 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id lAJ6QD6T006667
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 11:56:13 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAJ6QDRj2597100
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 11:56:13 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id lAJ6QCNW029300
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 06:26:13 GMT
Date: Mon, 19 Nov 2007 11:56:11 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH-RESEND] 2.6.24-rc2-mm1 powerpc (iseries)- build failure -
	mm/stab.c
Message-ID: <20071119062611.GA11135@linux.vnet.ibm.com>
References: <20071114105410.GA16846@linux.vnet.ibm.com>
	<20071119133849.bcfe52c1.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071119133849.bcfe52c1.sfr@canb.auug.org.au>
Cc: anton@au1.ibm.com, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@linux-foundation.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

Resubmitting the patch titled 
powerpc-iseries-build-failure-mm-stabc.patch in the -mm tree.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
--- linux-2.6.24-rc2/arch/powerpc/mm/stab.c	2007-11-07 03:27:46.000000000 +0530
+++ linux-2.6.24-rc2/arch/powerpc/mm/~stab.c	2007-11-19 19:43:55.000000000 +0530
@@ -20,6 +20,7 @@
 #include <asm/lmb.h>
 #include <asm/abs_addr.h>
 #include <asm/firmware.h>
+#include <asm/iseries/hv_call.h>
 
 struct stab_entry {
 	unsigned long esid_data;

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
