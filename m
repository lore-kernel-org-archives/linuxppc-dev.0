Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB611DE466
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 05:58:20 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46JwH3e026649
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:58:17 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m46JwHCU254114
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:58:17 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m46JwGKa030375
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:58:16 -0400
Date: Tue, 6 May 2008 14:57:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080506145703.11e7522c@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.26

to pick up a small number of fixes for 4xx.  One corrects the PCI
addresses for Sequoia boards, another fixes TLB issues with newer 440x6
cores.  Stefan's pci-e endpoint driver is also included here as it is
a fairly contained change with Ben's Ack.  It should have been included
in my last pull request, but I missed it and have been out.

thx,
josh

Christian Ehrhardt (1):
      [POWERPC] 4xx: Fix PCI mem in sequoia DTS

Stefan Roese (2):
      [POWERPC] 4xx: Fix problem with new TLB storage attibute fields on 440x6 c
      [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver

 arch/powerpc/boot/dts/sequoia.dts   |    9 ++-
 arch/powerpc/kernel/head_44x.S      |    9 ++-
 arch/powerpc/sysdev/ppc4xx_pci.c    |  180 +++++++++++++++++++++++++----------
 include/asm-powerpc/pgtable-ppc32.h |    7 ++
 4 files changed, 153 insertions(+), 52 deletions(-)
