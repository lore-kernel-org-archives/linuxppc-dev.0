Return-Path: <nfont@austin.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59BDDB7B9D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 09:07:44 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4I43FI017105
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 13:04:03 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA4M7fCD096322
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:07:41 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA4M7fT0011257
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:07:41 -0500
Message-ID: <4AF1FB29.50905@austin.ibm.com>
Date: Wed, 04 Nov 2009 16:07:37 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [RFC PATCH 0/5] Merge common dynamic OF device tree code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a follow on to Grant Likely's patches, attempting to merge the common
pieces of dynamic OF device tree updating.  These patches move the common
code for adding and removing nodes and properties from the device tree to
drivers/of/of_dynamic.c and wraps them under the new OF_DYNAMIC config
option.  Additionally this makes the necessary updates to powerpc and
microblaze arch's for this move.

Nathan Fontenot (5)
	- Move the declaration of devtree_lock and allnodes to linux/of.h
	- Create drivers/of/of_dynamic.c from common code.
	- powerpc and pseries updates
	- microblaze updates
	- powerpc/iseries updates
