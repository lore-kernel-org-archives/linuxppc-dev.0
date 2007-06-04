Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73412DDE09
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 04:51:11 +1000 (EST)
Subject: Re: [PATCH 6/8] Let subordinate transparent bridges be transparent.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1180740416.19517.476.camel@localhost.localdomain>
References: <1180720134.14219.66.camel@ld0161-tx32>
	<1180740416.19517.476.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1180983061.9632.24.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 13:51:01 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 18:26, Benjamin Herrenschmidt wrote:

> NAK. The mem case needs a similar fix. I think we should instead do
> 
> - 			if (!res->flags)
> - 				continue;
> + 			if (!res->flags || bus->self->transparent)
> + 				continue;

Right.  Fixed as indicated.

Thanks,
jdl
