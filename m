Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15EB9B7BF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Dec 2009 01:39:03 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB4ERmCl017878
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Dec 2009 09:27:48 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB4Ed0KG124600
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Dec 2009 09:39:00 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB44VTwq016715
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 23:31:30 -0500
Date: Fri, 4 Dec 2009 09:38:56 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20091204143856.GJ2937@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

A couple of DTS fixups for you.  Thanks.

josh

The following changes since commit 5a7b4193e564d1611ecf1cd859aed60d5612d78f:
  Benjamin Herrenschmidt (1):
        Revert "powerpc/mm: Fix bug in pagetable cache cleanup with CONFIG_PPC_SUBPAGE_PROT"

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Curtis Wald (1):
      powerpc/44x: Fix PCI node in Yosemite DTS

pbathija@amcc.com (1):
      powerpc/44x: Fix DMA ranges in DTS file for Katmai board.

 arch/powerpc/boot/dts/katmai.dts   |   22 +++++++++++-----------
 arch/powerpc/boot/dts/yosemite.dts |   14 ++------------
 2 files changed, 13 insertions(+), 23 deletions(-)
