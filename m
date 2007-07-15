Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EA10DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 18:57:11 +1000 (EST)
Subject: Re: How to add platform specific data to a of_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Beisert <jbe@pengutronix.de>
In-Reply-To: <200707151033.29894.jbe@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<200707151033.29894.jbe@pengutronix.de>
Content-Type: text/plain
Date: Sun, 15 Jul 2007 18:57:05 +1000
Message-Id: <1184489825.25235.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Hmm, as I stated above: Handling the SPI slave devices is done in the SPI 
> framework. But including this data into the dts sounds better than including 
> it into the BSP. Is there some documentation around how to describe such a 
> SPI bus with its devices in the dts?

I don't think so, I doubt there's an SPI OF binding. You'll have to
invent something and discuss it on the list.

Ben.
