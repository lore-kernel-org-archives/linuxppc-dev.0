Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 46980DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:48:16 +1000 (EST)
Date: Thu, 26 Jul 2007 17:47:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 0/3] [SPI] loopback mode support, [POWERPC] loopback mode
	for spi_mpc83xx
Message-ID: <20070726134754.GA3539@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
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

Here are three patches:
1. syncing spidev driver with new modes of spi subsystem;
2. spi subsystem support for loopback mode;
3. loopback mode support for spi_mpc83xx.

Because patch 3 depends on 1 and 2, I'm Cc'ing both lists
for all three patches.

They're based on Linus' tree as of today.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
