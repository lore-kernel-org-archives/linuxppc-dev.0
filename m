Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A028DDEBD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:14:55 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070403.165657.34759233.davem@davemloft.net>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403.165657.34759233.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:13:58 +1000
Message-Id: <1175649238.30879.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: paulus@samba.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 16:56 -0700, David Miller wrote:
> From: David Woodhouse <dwmw2@infradead.org>
> Date: Tue, 03 Apr 2007 19:28:36 -0400
> 
> > Abusing the 8250 device numbers prevents the 8250 module from being
> > loaded at the same time as pmac_zilog, and means you can't have both
> > internal port and PCMCIA or PCI 8250 ports active at the same time.
> 
> Dynamic minor number allocation for ttyS? would allow this
> just fine, and that's exactly what we do on sparc as I
> explained in another response.

If we can get it past whoever is the current 8250 maintainer, then fine
with me. Back then, I hit a brick wall.

Ben.
