Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D32BDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 22:37:10 +1100 (EST)
Date: Fri, 26 Jan 2007 20:37:04 +0900 (JST)
Message-Id: <200701261137.l0QBb5Us006131@toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 0/11] Patches for Toshiba Cell reference set
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

Paul-san,

This is a revised version of the patch set for Toshiba Cell reference
set (aka Celleb).


Changes from our previous patch set:

[PATCH 1/11] Celleb: interfaces to the hypervisor
* remove unused macros

[PATCH 2/11] Celleb: support interrupts
* remove unused variables
* cleanup spinlock initializing

[PATCH 3/11] Celleb: setup usb host controller in SCC
* add platform checking

[PATCH 4/11] Celleb: support iommu
* add platform checking

[PATCH 5/11] Celleb: htab routines
* add spinlock

[PATCH 6/11] Celleb: support udbg
* cleanup an unused variable

[PATCH 7/11] Celleb: hypervisor console driver
* add platform checking

[PATCH 8/11] Celleb: consolidate spu management ops
* spilit spu support patch into [8] and [9] (mostly NEW)
* consolidate spu management ops on of based platforms

[PATCH 9/11] Celleb: support spu priv1 ops
* spilit spu support patch into [8] and [9]
* chase changes of [8]

[PATCH 10/11] Celleb: basic support
* chase changes of [8]

[PATCH 11/11] Celleb: add celleb_defconfig
* nothing

Best regards,
Kou Ishizaki
Toshiba
