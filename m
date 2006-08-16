Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id F40D367B5A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 08:47:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Date: Thu, 17 Aug 2006 00:47:00 +0200
References: <200608162324.47235.arnd@arndb.de>
	<200608170016.47072.arnd@arndb.de>
	<20060816.152919.88472383.davem@davemloft.net>
In-Reply-To: <20060816.152919.88472383.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608170047.00811.arnd@arndb.de>
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Thursday 17 August 2006 00:29 schrieb David Miller:
> Didn't you say spidernet's facilities were sophisticated? :)
> This Tigon3 stuff is like 5+ year old technology.

I was rather overwhelmed by the 34 different interrupts that
the chip can create, that does not mean they chose the right
events for generating them.
Interestingly, spidernet has five different counters you can
set up to generate interrupts after a number of received frames,
but none for transmit...

	Arnd <><
