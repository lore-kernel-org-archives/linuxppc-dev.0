Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3627DDD07
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 04:18:33 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l44IIUMm028586
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 14:18:30 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44IITjL175338
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:18:29 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44IITSU009528
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:18:29 -0600
Received: from [9.10.86.166] (zod.rchland.ibm.com [9.10.86.166])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l44IITVd009520
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:18:29 -0600
Subject: [PATCH 0/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 04 May 2007 13:13:34 -0500
Message-Id: <1178302414.3026.202.camel@zod.rchland.ibm.com>
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

This is the initial round of support for the 750CL Holly eval board.  It
should also work for the 750GX Hickory board as well.  Overall this is
mostly ready to go, but I'm still fighting a minor issue with PCI.  I
wanted to get this put out for review while I fix that.

Comments welcome.

thx,
josh
