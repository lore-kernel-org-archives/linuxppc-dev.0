Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 7C788B7D74
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jun 2010 07:32:51 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zmta01.irigo.dk (Postfix) with ESMTP id 54711142C1A8E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 23:25:19 +0200 (CEST)
Received: from zmta01.irigo.dk ([127.0.0.1])
	by localhost (zmta01.irigo.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdQK60CHtnJ6 for <linuxppc-dev@ozlabs.org>;
	Fri,  4 Jun 2010 23:25:14 +0200 (CEST)
Received: from [192.168.1.127] (0x55532124.adsl.cybercity.dk [85.83.33.36])
	by zmta01.irigo.dk (Postfix) with ESMTP id 0A4D4142C1A87
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 23:25:14 +0200 (CEST)
Subject: [PATCH 0/2] ipic and pca953x irq patches
From: Esben Haabendal <eha@doredevelopment.dk>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Jun 2010 23:25:13 +0200
Message-ID: <1275686713.2970.12.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A minor bugfix for the ipic driver, and powerpc support for pca953x irq.

Esben Haabendal (2):
  powerpc: ipic: use set_irq_chip to ensure irq_chip defaults are
    applied
  gpio: pca953x: add powerpc irq support

 arch/powerpc/sysdev/ipic.c |    4 +-
 drivers/gpio/pca953x.c     |  347 ++++++++++++++++++++++++++++++--------------
 2 files changed, 242 insertions(+), 109 deletions(-)
