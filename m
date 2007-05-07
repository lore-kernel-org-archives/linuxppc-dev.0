Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E08DADDF14
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:28:24 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l47LP05i025606
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 17:25:00 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47LSJ1p170322
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 15:28:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47LSJ3D011227
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 15:28:19 -0600
Subject: [PATCH v4 0/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Mon, 07 May 2007 16:22:42 -0500
Message-Id: <1178572962.2990.197.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

This is round 4 of the patches to support the 750CL Holly board, and
hopefully the last.  They also fix one of the PCI issues I was seeing.

Included are a few TSI108 ethernet and PCI cleanups that should allow
for multiplatform builds for boards that contain a TSI chipset.

Paul, unless there are lots of comments on these, I'd like to get them
merged for 2.6.22.  Particularly patches 1, 2, and 3.  They should all
apply cleanly on top of your latest git tree.

thx,
josh
