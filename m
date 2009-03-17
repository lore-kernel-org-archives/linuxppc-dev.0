Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8F883DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 20:12:33 +1100 (EST)
From: Wolfgang Grandegegr <wg@grandegger.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 0/4] NAND: Multi-chip support for FSL-UPM for TQM8548 modules
Date: Tue, 17 Mar 2009 10:12:18 +0100
Message-Id: <1237281143-8768-1-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series adds generic support for multi-chip NAND devices
to the FSL-UPM driver and support for the Micron MT29F8G08FAB NAND flash
memory on the TQM8548 modules:

[PATCH 1/4] NAND: FSL-UPM: add multi chip support
[PATCH 2/4] NAND: FSL-UPM: add support for selecting chips via MAR
[PATCH 3/4] NAND: FSL-UPM: Add wait flags to support board/chip specific delays
[PATCH 4/4] powerpc/85xx: TQM8548: Update DTS file for multi-chip support

Wolfgang.
