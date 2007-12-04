Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C59FCDDF5F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 06:58:15 +1100 (EST)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0712041337530.12181@pademelon.sonytel.be>
References: <20071204060911.EA82BDDE19@ozlabs.org>
	<Pine.LNX.4.62.0712041337530.12181@pademelon.sonytel.be>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 06:57:59 +1100
Message-Id: <1196798279.13230.312.camel@pasglop>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-04 at 13:39 +0100, Geert Uytterhoeven wrote:
> 
> Can we please have them in <linux/ioport.h>? They look very useful to
> me
> elsewhere (other bus drivers, device drivers), too.
> 
> What about naming the printf format specifier macros more like in C99,
> e.g.
> PRI*?

That's a can of worms I just didn't want to open...

Ben.
