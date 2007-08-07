Return-Path: <pacman@shell01.TheWorld.com>
Received: from TheWorld.com (pcls6.std.com [192.74.137.146])
	by ozlabs.org (Postfix) with ESMTP id A7F52DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 14:16:23 +1000 (EST)
From: Alan Curry <pacman@theworld.com>
Message-Id: <200708070416.l774G3Qf728075@shell01.TheWorld.com>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
To: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 7 Aug 2007 00:16:03 -0400 (EDT)
In-Reply-To: <46B79562.9020202@genesi-usa.com> from "Matt Sealey" at Aug 06,
	2007 10:40:50 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm almost sorry I spoke up...

Matt Sealey writes the following:
>
>Okay before you add to the nvramrc you also need to add probe-all to build the
>device tree first; I assumed this was common knowledge.

Maybe for experienced OpenFirmware developers; this is the first time I've
had to touch the stuff. So first I had to learn Forth. To patch the kernel
you only need to know C. (Of course I already knew C -- it's common
knowledge.)
