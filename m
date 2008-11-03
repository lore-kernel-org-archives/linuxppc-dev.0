Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A42ADDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:01:41 +1100 (EST)
Received: id: bigeasy by Chamillionaire.breakpoint.cc authenticated by bigeasy
	with local (easymta 1.00 BETA 1) id 1Kx5cG-0008AW-Sb
	for linuxppc-dev@ozlabs.org; Mon, 03 Nov 2008 21:01:36 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: Add kexec support for fsl-book-e [V2]
Date: Mon,  3 Nov 2008 21:01:34 +0100
Message-Id: <1225742496-31319-1-git-send-email-sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the kernel part of the kexec support for mpc8544 / FSL BookE.
This version should fix the two things Ben noticed during his review.

Changelog:
 v1: - Removed runtime detection between fsl-book-e & no-mmu part
     - Marked the mmu-setup part as FSL BookE because it does not work
       on BooKE in general

Sebastian
