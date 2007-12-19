Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E466DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 03:39:26 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBJGdBOZ018819
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 11:39:11 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBJGdBCg454818
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 11:39:11 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBJGdB4i027098
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 11:39:11 -0500
Received: from zod.rchland.ibm.com (wecm-9-67-132-88.wecm.ibm.com
	[9.67.132.88])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lBJGdBrj027071
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 11:39:11 -0500
Date: Wed, 19 Dec 2007 10:33:51 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] Merge mkimage tool
Message-ID: <20071219103351.6c4468f4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches merge the mkimage tool into the kernel.  For now,
this is just an RFC, which is why I'm only posting it here.  If enough
people agree that this is a good idea, then I'll post it to LKML.  Note
that mkimage is always generated.  It should probably only be built for
platforms that need it, but I didn't figure out how to do that yet.

This is currently based on the mkimage version found in U-Boot 1.3.1.

Comments, flames, suggestions, insults, monetary donations welcome.

josh
