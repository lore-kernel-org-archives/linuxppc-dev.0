Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FC52B718C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Nov 2010 23:01:27 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH V2 0/3] at24: parse OF-data
Date: Wed, 17 Nov 2010 13:00:47 +0100
Message-Id: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is the second round of this series:

* 1/3 now uses __be32 instead of u32.
* 2/3 is new and adds some more sanity checks
* 3/3 is unchanged

Grant, I hope you can pick 2/3 as well. Should make things easier and it is
just a misc-driver (which I maintain) :)

Wolfram Sang (3):
  misc: at24: parse OF-data, too
  misc: at24: add more sanity checks for parameters
  powerpc: pcm030/032: add pagesize to dts

 Documentation/powerpc/dts-bindings/eeprom.txt |   28 ++++++++++++++++
 arch/powerpc/boot/dts/pcm030.dts              |    1 +
 arch/powerpc/boot/dts/pcm032.dts              |    3 +-
 drivers/misc/eeprom/at24.c                    |   43 +++++++++++++++++++++---
 4 files changed, 68 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/eeprom.txt

-- 
1.7.2.3
