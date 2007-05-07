Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63C08DDE46
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 00:54:21 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47EsG7E024356
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 10:54:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47EsGjA175798
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 08:54:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47EsFQg009576
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 08:54:15 -0600
Subject: [PATCH v3 0/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Mon, 07 May 2007 09:48:44 -0500
Message-Id: <1178549324.2990.52.camel@zod.rchland.ibm.com>
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

This is round 3 of the patches to support the 750CL Holly board.  I
think I've gotten all the comments from rounds 1 and 2 fixed up now.

Included are a few TSI108 ethernet and PCI cleanups that should allow
for multiplatform builds for boards that contain a TSI chipset.

Paul, I think patches 1, 2, and 3 are ready to be merged.  And unless
there are lots of comments on the rest, I'd like to get them merged for
2.6.22 as well if possible.

thx,
josh
