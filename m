Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C98C4DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 22:58:32 +1000 (EST)
Subject: Re: [PATCH] [V5] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200904241301.59775.arnd@arndb.de>
References: <20090417205119.3D35660055@mail16-sin.bigfish.com>
	<200904241301.59775.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 27 Apr 2009 22:58:07 +1000
Message-Id: <1240837087.7169.11.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-24 at 13:01 +0200, Arnd Bergmann wrote:

> I just said in another email thread that we would need a CONFIG_DCR
> option that DCR using drivers should depend on, if it ever happened
> outside of powerpc.
>
> Well, apparently this happened earlier than I expected.

Sadly...

Cheers,
Ben.
