Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BC78DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 16:16:25 +1000 (EST)
Subject: sfx.c driver build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Brown <mbrown@fensystems.co.uk>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2008 16:15:59 +1000
Message-Id: <1216966559.11188.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Michael !

The sfx driver (which happens to be part of some of our test configs)
fails to build in current Linus tree on powerpc with this error:

/home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c: In function ‘efx_probe_interrupts’:
/home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c:845: error: lvalue required as unary ‘&’ oper
and

Cheers,
Ben.
