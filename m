Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 106E5DDFDF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:53:33 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3U7quCt006800
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:52:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U7rlU0206434
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:53:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U7nl6h000398
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:49:47 +1000
Message-Id: <20080430074621.104662132@au1.ibm.com>
Date: Wed, 30 Apr 2008 17:46:21 +1000
From: markn@au1.ibm.com
To: olof@lixom.net
Subject: [RFC] [PATCH 0/5] [POWERPC] Implement dma_*map*_attrs() and
	DMA_ATTR_WEAK_ORDERING and use on Cell
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-- 
Was Re: [PATCH] [POWERPC] Add struct iommu_table argument to iommu_map_sg()

Here's the patch series that follows on from the patch:
Add struct iommu_table argument to iommu_map_sg()

Thanks!

Mark.
