Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D336C67A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 13:07:45 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <det.nicolas@free.fr>
In-Reply-To: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
References: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 13:03:14 +1100
Message-Id: <1110333794.32525.17.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> About arch/ppc/syslibs/ mv64x60 code. Well, it's a bit evil as it has
> hardcoded IRQ, hardcoded register base, it changes 
> chipset configuration... whereas all of these is already done by the
> Pegasos II OpenFirmWare.

Embedded people don't understand what a firmware is ;)

(sorry, couldn't resist ...)
