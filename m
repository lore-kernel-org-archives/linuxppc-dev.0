Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D040DDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:18:50 +1100 (EST)
Subject: Re: [PATCH 3/3] Add device tree compatible aliases to i2c drivers
From: Jon Loeliger <jdl@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20080128144209.8410.37884.stgit@terra.home>
References: <20080128144202.8410.14647.stgit@terra.home>
	<20080128144209.8410.37884.stgit@terra.home>
Content-Type: text/plain
Message-Id: <1201540252.24073.6.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 28 Jan 2008 11:10:55 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-01-28 at 08:42, Jon Smirl wrote:
> PowerPC device trees use a different naming convention than the Linux kernel.  Provide alias names for i2c drivers in order to allow them to be loaded by device tree name. The OF_ID macro ensures that the aliases are only present in powerpc builds and separated into their own namespace.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---

Hi Jon,

Any chance we can have hard 70-ish column limited
log messages, please?

Thanks,
jdl
