Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5FB2EDDF3F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 08:00:43 +1000 (EST)
Date: Mon, 7 Apr 2008 15:00:27 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407220027.GA24510@farnsworth.org>
MIME-Version: 1.0
Subject: [PATCH 0/8 v3] [POWERPC] mv64x60 and prpmc2800 DTS cleanups
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches again attempts to clean up and document
the Marvell MV64x60 device tree.  It supersedes Mark Greer's
series posted on 11 December 2007.  See:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047986.html

These apply on the powerpc-next branch, and I'd like to get them
into 2.6.26.

This series differs from v2 in that the compatible property
prefix string has been left unchanged as "marvell".

Thanks,
-Dale
