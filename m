Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56488B7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 16:00:46 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0L4h5PY010406
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 23:43:14 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1B50F4DE8026
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Jan 2011 23:57:21 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0L50fCZ350352
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jan 2011 00:00:41 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0L50d4c026482
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jan 2011 00:00:40 -0500
Date: Fri, 21 Jan 2011 00:00:10 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
Subject: [PATCH 0/4] powerpc/pseries: VPHN code cleanups
Cc: markn@au1.ibm.com, tbreeds@au1.ibm.com, lkessler@us.ibm.com,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>, mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

This patch set includes some simple style cleanups for VPHN:

PATCH 1/4: powerpc/pseries: Fix typo in VPHN comments
PATCH 2/4: powerpc/pseries: Fix brace placement in numa.c
PATCH 3/4: powerpc/pseries: Remove unnecessary initializations in numa.c
PATCH 4/4: powerpc/pseries: Reorder VPHN functions to reduce forward 
                            declarations

 arch/powerpc/mm/numa.c |  143 +++++++++++++++++++++++-------------------------
 1 files changed, 69 insertions(+), 74 deletions(-)
