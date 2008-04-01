Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A330DDE19
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 12:12:36 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 00/11] ppc32 mm init clean and 85xx kernel reloc
Date: Mon, 31 Mar 2008 21:08:24 -0500
Message-Id: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This set of patches cleans up the initialization of various mmu bits on
ppc32 (and a small bit on ppc64 to maintain common code) towards the
goal of having an 85xx (book-e) kernel able to run at non-zero offsets.

These patches exist in my master and ppc32_mm_init branch.  I've dropped
them from the powerpc-next as paulus wants them to go via his tree
directly since they touch common code.

- k
