Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 58977DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 21:28:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support
	ofMPC8641D
Date: Thu, 24 May 2007 13:27:28 +0200
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<200705241119.23793.arnd@arndb.de>
	<46B96294322F7D458F9648B60E15112C307092@zch01exm26.fsl.freescale.net>
In-Reply-To: <46B96294322F7D458F9648B60E15112C307092@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705241327.28439.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 May 2007, Zhang Wei-r63237 wrote:
> 
> Add the rio scaning code to of_platform.c such as pci is ok?

I think it's better to have a separate file that consolidates
all the code specific to one rio bus bridge.

There is no technical reason why the of_pci_phb code is in
of_platform.c either, it more or less ended up in there by
accident ;-)

	Arnd <><
