Return-Path: <markn@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85C79DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 14:37:28 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m414bQ7g011589
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 14:37:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m414bKiM4632714
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 14:37:20 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m414bbRs023494
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 14:37:37 +1000
Message-Id: <20080501042949.237603158@au1.ibm.com>
Date: Thu, 01 May 2008 14:29:49 +1000
From: markn@au1.ibm.com
To: paulus@samba.org
Subject: [PATCH 0/6] [POWERPC] Implement dma_*map*_attrs() and
	DMA_ATTR_WEAK_ORDERING, use on Cell
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
Hi Paul,

Any chance of these patches getting into .26? They were held up waiting
for the new dma_*map*_attrs() patches to go in (which made it in from -mm
on the 29th)...

Thanks!

Mark.
