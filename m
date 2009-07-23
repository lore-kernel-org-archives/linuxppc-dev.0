Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 72A6FB7C53
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 17:44:57 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C0C5DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 17:44:56 +1000 (EST)
Subject: Re: [PATCH 0/5] Generic NVRAM support for large MMIO devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain
Date: Thu, 23 Jul 2009 17:44:37 +1000
Message-Id: <1248335077.3367.79.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-02 at 17:12 +0100, Martyn Welch wrote:
> The following series allows the generic NVRAM driver to access MMIO
> based NVRAMs. In addition it enables support for NVRAMs of sizes
> differing from those found on PowerPC Macs (providing a safe
> fallback). Patches are also included to enable support for the NVRAM
> found on the GE Fanuc PPC9A, SBC310 and SBC610.
> 
> If this patch series is unsuitable this late in the day for 2.6.31,
> please concider it for 2.6.32.

No major issue with the series other than the change to the generic
nvram code which needs to not break other architectures :-) Also,
it will probably need to go through Andrew Morton, unless there's
a maintainer for that driver, is there ?

Once you sort out that aspect of the patch series, I'm happy to take
the rest in powerpc.git

Cheers,
Ben.
