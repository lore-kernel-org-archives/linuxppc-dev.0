Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E149DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 02:18:42 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45GIdjq001444
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:18:39 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45GIdKi201784
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 10:18:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45GId57011902
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 10:18:39 -0600
Received: from [9.67.207.4] (wecm-9-67-207-4.wecm.ibm.com [9.67.207.4])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l45GIcYK011873
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 10:18:38 -0600
Subject: [PATCH v2 0/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Sat, 05 May 2007 11:13:31 -0500
Message-Id: <1178381611.3393.25.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

This is round 2  of the patches to support the 750CL HOlly eval board.
It should also work for the 750GX Hickory board as well.  I think most
of the comments on the previous round have been addressed.

Included are a few TSI108 ethernet and PCI cleanups that should allow
for multiplatform builds for boards that contain a TSI chipset.

As always, comments welcome.

josh
