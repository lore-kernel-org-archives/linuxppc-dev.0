Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A7E968775
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 08:38:26 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5534EC32-EE72-4019-A5D9-305F8348E4D9@kernel.crashing.org>
References: <20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
	<1132136755.21643.40.camel@hades.cambridge.redhat.com>
	<17277.10875.334722.856865@cargo.ozlabs.ibm.com>
	<3F990F6D-7A3F-47CA-938F-968593678895@kernel.crashing.org>
	<1132285818.20016.79.camel@gaston>  <20051118082358.GA2309@lst.de>
	<1132311088.20016.88.camel@gaston>
	<5534EC32-EE72-4019-A5D9-305F8348E4D9@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 08:36:34 +1100
Message-Id: <1132349794.20016.94.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> How early on can we use udbg? I'd be interested to see how this is  
> going to work out for 4xx/83xx/85xx w/built-in 8250's.

As soon as you can get something mapped I suppose... On ppc32 with
BootX, I setup a BAT in head.S, thus udbg is available in
machine_init(). On ppc64 with hypervisor console, we can enable hacks
that initialize udbg in real mode.

Ben.
