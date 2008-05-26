Return-Path: <markn@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96760DDFB0
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:32 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4Q4Ix3G002242
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:18:59 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4Q4NdCj277784
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:23:39 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4Q4JUTZ029402
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:30 +1000
Message-Id: <20080526041430.324464061@au1.ibm.com>
Date: Mon, 26 May 2008 14:14:30 +1000
From: markn@au1.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [patch 0/6] Implement dma_*map*_attrs() and DMA_ATTR_STRONG_ORDERING,
	use on Cell
Cc: arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-- 
This is a resend of the patchset sent out on 2008-05-01 titled
"Implement dma_*map*_attrs() and DMA_ATTR_WEAK_ORDERING, use on Cell".

The first five patches are the same, but patch #6 has been redone because
on Cell the default should be to use weakly ordered mappings rather than
strongly ordered. Thus the DMA attribute that is added in this patch has
been changed from DMA_ATTR_WEAK_ORDERING to DMA_ATTR_STRONG_ORDERING.

Thanks!

Mark.
