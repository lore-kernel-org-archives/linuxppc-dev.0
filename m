Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3C41DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:50:17 +1100 (EST)
Subject: Re: Sequoia EMAC only works if u-boot initializes it?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <474B4CA9.3070506@harris.com>
References: <474AED67.4020006@harris.com> <200711261720.26629.sr@denx.de>
	<474B1A11.90806@harris.com> <1196107715.7195.107.camel@pasglop>
	<474B4CA9.3070506@harris.com>
Content-Type: text/plain
Date: Tue, 27 Nov 2007 09:49:58 +1100
Message-Id: <1196117398.7157.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-26 at 17:46 -0500, Steven A. Falco wrote:
> With the following 15 patches on top of the DENX git tree, I have both emac ports working:

.../...

Good. All of these should go in 2.6.25 (not .24 at this stage though).

I suppose DENX will pick them up asap.

Cheers,
Ben.
