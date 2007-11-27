Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 644DEDDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 02:32:17 +1100 (EST)
Date: Tue, 27 Nov 2007 18:37:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH 0/3] OF-platform PATA driver
Message-ID: <20071127153708.GA12490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>,
	Arnd Bergmann <arnd@arndb.de>
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

Here is the second spin of the OF-platform PATA driver and
related patches.

Changes since RFC:
- nuked drivers/ata/pata_platform.h;
- powerpc bits: proper localbus node added.


Thanks for the previous review! This time I'm collecting acks,
don't be shy to give 'em generously. ;-)


Good luck,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
