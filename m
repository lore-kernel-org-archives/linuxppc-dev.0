Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2020DE297
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:53:09 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 00/12 v3] [POWERPC] ppc32 mm init clean and 85xx kernel reloc
Date: Thu, 10 Apr 2008 05:48:39 -0500
Message-Id: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Updated the phys_addr_t patch to be a bit cleaner
* reworked order of patches a bit (bootwrapper now second to last)
* added patch to properly set physical address of PHDR
* reverted change in prom.c to use PHYSICAL_START & klimit for lmb_reserve

These patches exist in the following git tree:

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git ppc32_mm_init

- k
