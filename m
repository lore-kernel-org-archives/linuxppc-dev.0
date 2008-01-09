Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 60937DE152
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:59:48 +1100 (EST)
Date: Wed, 9 Jan 2008 22:08:52 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH v4 0/3] OF-platform PATA driver
Message-ID: <20080109190852.GA18827@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Olof Johansson <olof@lixom.net>, Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here is the resend (aka v4) version of the OF-platform PATA
driver and related patches.

Changes since v3:
- Acked-by: Paul Mundt <lethal@linux-sh.org>
- In the powerpc specific patch: update defconfig and use
  machine_device_initcall -- this is new call found in the
  galak/powerpc.git.

Changes since v2:
- "PPC" added to PATA_PLATFORM "depends on" Kconfig entry;
  I didn't remove EMBEDDED "depends on" -- this wasn't discussed
  much and these patches should not depend on the decision.
- cosmetic fixes;
- "s/ioport_shift/reg_shift/g" patch dropped.

Changes since v1:
- __pata_platform_probe now accepts pio_mask argument;
- pata-platform compatible property renamed to ata-generic;
- pata_of_platform understands pio-mode property. It's used to pass
  pio_mask to the __pata_platform_probe. That is, in ata-generic
  context pio-mode means "pio mode the bus already configured for";
- New optional patch that renames pata_platform_info's
  ioport_shift to reg_shift.

Changes since RFC:
- nuked drivers/ata/pata_platform.h;
- powerpc bits: proper localbus node added.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
