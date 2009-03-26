Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CC01DDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 11:02:10 +1100 (EST)
Subject: Re: [PATCH 04/57] microblaze_v7: Open firmware files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090323205305.GA10576@oksana.dev.rtsoft.ru>
References: <1237408284-8674-1-git-send-email-monstr@monstr.eu>
	<4b5aee01d11fc790c7842838ea63a82ee3273003.1237407249.git.monstr@monstr.eu>
	<af309ba8e95f503b7990461384d9f8453f45dbbd.1237407249.git.monstr@monstr.eu>
	<200903231951.23902.arnd@arndb.de>
	<20090323205305.GA10576@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Thu, 26 Mar 2009 11:01:39 +1100
Message-Id: <1238025699.25062.756.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-23 at 23:53 +0300, Anton Vorontsov wrote:
> It took me approx. 4 hours to factor out the code and make a
> proof-of-concept FDT support for a little-endian ARM platform. ;-)
> (The device tree was only describing a cpu and a nor flash, though.
> No support for interrupt- and gpio-controllers. And no support for
> U-Boot, I just built the dtb file into the kernel).

ARM could benefit tremendously I believe from a similar virtualized
interrupt mapping & OF tree to powerpc for their gazillions of weirdly
cascaded interrupt controller setups :-)

Ben.
