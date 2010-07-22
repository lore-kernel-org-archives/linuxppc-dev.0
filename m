Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7A67B70CE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 17:51:01 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6M7ov6E007834
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 17:50:57 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6M7oxon1487050
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 17:51:00 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6M7oxgt004886
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 17:50:59 +1000
Message-ID: <4C47F861.8080501@linux.vnet.ibm.com>
Date: Thu, 22 Jul 2010 13:20:57 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	David Airlie <airlied@linux.ie>
Subject: build failure with kernel 2.6.35-rc5-git6/git7 on power box
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The kernel versions 2.6.35-rc5-git6(commitid f4b23cc2d5dc78ef) and 2.6.35-rc5-git7(commitid cd5b8f8755a89a5) fails
to build on power6 and power5 machines with the following error


   drivers/gpu/drm/ttm/ttm_page_alloc.c: In function 'set_pages_array_wb':
   drivers/gpu/drm/ttm/ttm_page_alloc.c:227: error: implicit declaration of function 'unmap_page_from_agp'
   drivers/gpu/drm/ttm/ttm_page_alloc.c: In function 'set_pages_array_wc':
   drivers/gpu/drm/ttm/ttm_page_alloc.c:238: error: implicit declaration of function 'map_page_into_agp'
   drivers/gpu/drm/ttm/ttm_page_alloc.c: In function 'ttm_pool_mm_shrink_init':
   drivers/gpu/drm/ttm/ttm_page_alloc.c:419: warning: assignment from incompatible pointer type
   make[4]: *** [drivers/gpu/drm/ttm/ttm_page_alloc.o] Error 1
   make[3]: *** [drivers/gpu/drm/ttm] Error 2

Thanks
Divya
