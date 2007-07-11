Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F6ADDDE32
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:52:50 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BDqlAY029013
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:52:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BDqcZ9090060
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:52:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BDqcbL018818
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:52:38 -0600
Subject: [RFC][PATCH 0/8] arch/powerpc support for Walnut Board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 11 Jul 2007 08:52:37 -0500
Message-Id: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those interested, here's my current patch set to get PPC405 support
working in arch/powerpc.

Patches 1, 2, 3, 4, and 5 are probably ready to merge whenever.  The
patches specific to Walnut need some more work before I would consider
those remotely usable.  However, you can use them to build a zImage that
correctly determines the clocking and has a working serial console.

As always, comments welcome.

josh
