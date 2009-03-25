Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C57DEDDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 21:08:24 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/4] NAND: Multi-chip support for FSL-UPM for TQM8548
	modules
Date: Wed, 25 Mar 2009 11:08:17 +0100
Message-Id: <1237975701-23201-1-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is my third version of the patch series adding generic support
for multi-chip NAND devices to the FSL-UPM driver and support for
the Micron MT29F8G08FAB NAND flash memory on the TQM8548 modules.
It addresses the issues reported on the mailing list, e.g. the new
bindings are now documented as well.

[PATCH v3 1/4] NAND: FSL-UPM: add multi chip support
[PATCH v3 2/4] NAND: FSL-UPM: Add wait flags to support board/chip specific delays
[PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
[PATCH v3 4/4] powerpc/85xx: TQM8548: Update DTS file for multi-chip support

Please consider these patches for inclusion into kernel version 2.6.30. 
Patch 3 and 4 should go through the powerpc maintainer(s).

Thanks.

Wolfgang.
