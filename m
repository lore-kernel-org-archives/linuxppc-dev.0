Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 704CADDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 02:24:20 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/5] NAND: Multi-chip support for FSL-UPM for TQM8548
	modules
Date: Thu, 19 Mar 2009 16:16:03 +0100
Message-Id: <1237475768-11481-1-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the 2nd version of the patch series adding generic support for
multi-chip NAND devices to the FSL-UPM driver and support for the
Micron MT29F8G08FAB NAND flash memory on the TQM8548 modules. It
addresses the issues reported on the mailing list, e.g. the new
bindings are now documented:

[PATCH v2 1/5] NAND: FSL-UPM: add multi chip support
[PATCH v2 2/5] NAND: FSL-UPM: add support for selecting chips via MAR
[PATCH v2 3/5] NAND: FSL-UPM: Add wait flags to support board/chip specific delays
[PATCH v2 4/5] powerpc: NAND: FSL UPM: document new bindings
[PATCH v2 5/5] powerpc/85xx: TQM8548: Update DTS file for multi-chip support

Please consider these patches for kernel inclusion.

Thanks.

Wolfgang.
