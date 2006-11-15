Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E82E067C84
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 21:57:01 +1100 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id kAF9IsKY014648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:18:55 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAF9ImiJ014666
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:18:48 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAF9ImK4017579
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:18:48 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAF9IlV0024436
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:18:47 +0900 (JST)
Date: Wed, 15 Nov 2006 18:18:45 +0900 (JST)
Message-Id: <200611150918.kAF9IllU012977@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/16] powerpc: add platform celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear everyone,

This is the patch set (besed on 2.6.19-rc4) for Toshiba Cell reference
set. The reference set consists of Cell, 512MB memory, SCC and some
peripherals such as HDD, GbE, etc.  You can see brief explanation and
picture of Cell reference set at following URLs.

    http://www.toshiba.co.jp/about/press/2005_09/pr2001.htm
    http://cell-industries.com/toshiba_announces.php

SCC(Super Companion Chip) is Toshiba's southbridge chip for Cell. I
can't explain precisely about differences between SCC and Spider, but
we believe that they are almost same each other.

In addition to SCC, we have FW and Hypervisor on our Cell reference
set. The FW initializes HW and loads SW modules to memory. Linux is
also loaded by FW.  Hypervisor is Toshiba original one and we call it
"Beat". Our Linux runs on Beat, so the patches includes the hypervisor
call such as pte access interfaces.

The set of patches also includes drivers for IDE, GbE and PCI bus, but
does not include PICe and AV devices in this time.
USB driver is not included in this set. Instead, Ben-san posted it to
linux-usb-devel last week and it's being reviewd now.

This patch set is intended to be merged to 2.6.20.
If you have any comment, please write to me.

Thank you,
Kou Ishizaki
Toshiba
