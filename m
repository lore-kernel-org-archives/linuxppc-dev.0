Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F4896877E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 14:53:54 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3F990F6D-7A3F-47CA-938F-968593678895@kernel.crashing.org>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
	<1132136755.21643.40.camel@hades.cambridge.redhat.com>
	<17277.10875.334722.856865@cargo.ozlabs.ibm.com>
	<3F990F6D-7A3F-47CA-938F-968593678895@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 14:50:17 +1100
Message-Id: <1132285818.20016.79.camel@gaston>
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

On Thu, 2005-11-17 at 21:26 -0600, Kumar Gala wrote:
> Paul or BenH,
> 
> Would you like to enlighten us on this ambitious rework?

First, some better & more generic routines for translating addresses
from the device-tree, and some more generic code for looking for
standard serial port using the above routines, among others ... also,
set_preferred_console gets modified to use the previous list so it can
detect the ports more reliably, etc ....

Ben.
