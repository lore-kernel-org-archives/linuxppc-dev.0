Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32F34DDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 04:26:23 +1000 (EST)
In-Reply-To: <200706281647.57408.arnd@arndb.de>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<200706272256.16418.arnd@arndb.de>
	<46B96294322F7D458F9648B60E15112C6F31B2@zch01exm26.fsl.freescale.net>
	<200706281647.57408.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f898cd2f2d13e5bbdbc6306781257f2e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/5 v2] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Thu, 28 Jun 2007 20:26:13 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Of course, looking at the device tree, rapidio is a device, not a bus,
> because it does not have a device_type and it does not have any 
> children
> of its own.

It's a device _of course_, but it's also a bus parent, since
it has a "#address-cells" not equal to zero (and, if this used
real OF, it would have decode-unit and encode-unit methods).
A quite empty bus perhaps heh (in this device tree, anyway).


Segher
