Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79E00B7B9C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 10:09:29 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAHKtWnq004461
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 15:55:32 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAHL46VP111894
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:04:06 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAHL448W004732
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:04:06 -0500
Message-ID: <4B030FC2.9070401@austin.ibm.com>
Date: Tue, 17 Nov 2009 15:04:02 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 0/4] Merge OF dynamic patches
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches merges the common dynamic device tree
updating routines of_attach_node() and of_detach_node() to
drivers/of/of_dynamic.c.

Built and tested on powerpc, I have no access to build/test
this on microblaze.

-Nathan Fontenot

1/4 - Merge of_attach_node
2/4 - Merge of_detach_node
3/4 - Makefile/Kconfig updates
4/4 - Move declarations to linux/of.h
