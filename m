Return-Path: <dave@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2371DDFB1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 05:36:12 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBIYwaZ024338
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:34:58 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBIa7aZ196414
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:36:07 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBIa6cT017968
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:36:07 -0700
Subject: [PATCH 1/2] remove unused i var
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Thu, 11 Dec 2008 10:36:04 -0800
References: <20081211183603.981E651D@kernel>
In-Reply-To: <20081211183603.981E651D@kernel>
Message-Id: <20081211183604.2B450FD3@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	"Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN arch/powerpc/mm/numa.c~remove-unused-i-var arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~remove-unused-i-var	2008-12-11 09:12:57.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-11 09:12:57.000000000 -0800
@@ -929,7 +929,6 @@ static void mark_reserved_regions_for_ni
 void __init do_init_bootmem(void)
 {
 	int nid;
-	unsigned int i;
 
 	min_low_pfn = 0;
 	max_low_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
_
