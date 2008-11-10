Return-Path: <martyn.welch@gefanuc.com>
Received: from welchma.Radstone.Local (unknown [193.130.116.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 043A0474D2
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 23:48:25 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 0/2] GE Fanuc's FPGA based watchdog
To: linuxppc-dev@ozlabs.org
Date: Mon, 10 Nov 2008 12:29:01 +0000
Message-ID: <20081110122356.10813.29954.stgit@welchma.Radstone.Local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: wim@iguana.be, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements and enables support for the FPGA based
watchdog timers found on GE Fanuc's SBC610.

There are two identical watchdog timers at different offsets in the above
mentioned boards, however the current driver is only capable of supporting
one of them.

The watchdog timers are also capable of generating interrupts at a
user-configurable threshold, though support for this operation is currently
not supported by the driver.

---

Martyn Welch (2):
      powerpc: Enable watchdog timer on GE Fanuc's SBC610
      watchdog: Basic support for GE Fanuc's FPGA based watchdog timer


 arch/powerpc/boot/dts/gef_sbc610.dts           |   15 +
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    1 
 drivers/watchdog/Kconfig                       |    6 
 drivers/watchdog/Makefile                      |    1 
 drivers/watchdog/gef_wdt.c                     |  333 ++++++++++++++++++++++++
 5 files changed, 356 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/gef_wdt.c

-- 
Signature
