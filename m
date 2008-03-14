Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 439C3DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 23:18:22 +1100 (EST)
Date: Fri, 14 Mar 2008 21:18:14 +0900 (JST)
Message-Id: <20080314.211814.-1300521960.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 0/11] celleb: patchset for 2.6.26 (take 2)
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a second round of the patchset for 2.6.26 which contains
following changes:

- cleanup                                 [PATCH 1/11]
- consolidate io-workarounds code         [PATCH 2/11]..[PATCH 3/11]
- move celleb files into platforms/cell/  [PATCH 4/11]..[PATCH 9/11]
- add support for celleb PCI Express      [PATCH 10/11]
- bug fix                                 [PATCH 11/11]

Please test consolidating io-workarounds patch on CellBlade because I
don't have any access to CellBlade.


Changes from previous patchset:

[PATCH 1/11] celleb: coding style cleanup
 - Rebase to current powerpc.git.

[PATCH 2/11] cell: generalize io-workarounds code
 - Change patch order.
 - Use dma_mapping_error() to check the result of dma_map_single().

[PATCH 3/11] celleb: consolidate io-workarounds code
 - Change patch order.

[PATCH 4/11] celleb: move the base part for celleb support
[PATCH 5/11] celleb: move the SCC related code for celleb
[PATCH 6/11] celleb: move files for Beat hvcall interfaces
[PATCH 7/11] celleb: move files for Beat mmu and iommu
[PATCH 8/11] celleb: move a file for SPU on Beat
[PATCH 9/11] celleb: move miscellaneous files for Beat
 - Rebase to current powerpc.git.
 - Change patch order.
 - Split Makefile changes so that this patchset won't cause problems
   when we use git-bisect.

[PATCH 10/11] celleb: add support for PCI Express
 - Fix checking the result of dma_map_single().

[PATCH 11/11] hvcbeat: fix buffer manipulation
 - Nothing.

Best regards,
Kou Ishizaki
