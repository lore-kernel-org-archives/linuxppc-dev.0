Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF40067C52
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 13:38:21 +1100 (EST)
Date: Tue, 12 Dec 2006 11:38:05 +0900 (JST)
Message-Id: <200612120238.kBC2c944027918@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/17] Patches for Toshiba Cell reference set
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

This is a second round of the patch set for Toshiba Cell reference
set. Thank you for your useful comments about our first patch and
they were reflected on the whole.

The reference set consists of Cell, 512MB memory, SCC and some
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
