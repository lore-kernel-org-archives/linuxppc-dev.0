Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91C97DDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 16:22:34 +1000 (EST)
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Curry <pacman@theworld.com>
In-Reply-To: <200707250128.l6P1SWSF1336935@shell01.TheWorld.com>
References: <200707250128.l6P1SWSF1336935@shell01.TheWorld.com>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 16:22:28 +1000
Message-Id: <1185344548.5439.308.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-24 at 21:28 -0400, Alan Curry wrote:
> As of 2.6.22 the kernel doesn't recognize the i8042 keyboard/mouse controller
> on the PegasosPPC. This is because of a feature/bug in the OF device tree:
> the "device_type" attribute is an empty string instead of "8042" as the
> kernel expects. This patch (against 2.6.22.1) adds a secondary detection
> which looks for a device whose *name* is "8042" if there is no device whose
> *type* is "8042".
> 
> Signed-off-by: Alan Curry <pacman@world.std.com>

Doesn't it have something in "compatible" instead ? that would be the
way to go.

Ben.
