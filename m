Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C19C7474D7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 14:10:28 +1100 (EST)
Subject: Re: [PATCH v2] serial: add support for the cell network processor
	NWP device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200811241453.32166.arnd@arndb.de>
References: <200811241453.32166.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 14:08:14 +1100
Message-Id: <1231297694.14860.55.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-24 at 14:53 +0100, Arnd Bergmann wrote:
> From: Benjamin Krill <ben@codiert.org>
> 
> Add support for the nwp serial device which is connected to a DCR bus. It
> uses the of_serial device driver to determine necessary properties from
> the device tree.  The supported device is added as serial port number 84.
> 
> NWP stands for network processor and it is part of the QPACE - Quantum
> Chromodynamics Parallel Computing on the Cell Broadband Engine project.
> The implementation is a lightweight uart implementation with the focus
> to consume as little resources as possible and it is connected to a
> DCR bus.
> 
> Signed-off-by: Benjamin Krill <ben@codiert.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

There have been no comment nor objection about this patch.

Andrew, do we have a serial maintainer or should I merge it via the
powerpc tree ?

Cheers,
Ben.
