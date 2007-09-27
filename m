Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3B9BDDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 18:25:35 +1000 (EST)
Subject: Re: [PATCH 7/7] Celleb: update for PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200709261409.32231.arnd@arndb.de>
References: <20070926.134050.1102532600.kouish@swc.toshiba.co.jp>
	<200709261409.32231.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 18:25:27 +1000
Message-Id: <1190881527.6158.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-09-26 at 14:09 +0200, Arnd Bergmann wrote:
> Is there a way that we can make that code common? I guess there could be a
> file in arch/powerpc/sysdev that can handle this correctly for all hardware
> that requires this particular workaround (currently celleb and QS20, but
> potentially more).

We could move it to something like sysdev/spider-pci-workarounds.c

Another thing to note is that the initial implementation I did for QS20
only does PCI, not PCIE. Maybe that's worth fixing on both.

Ben.
