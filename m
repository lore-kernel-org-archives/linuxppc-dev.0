Return-Path: <pacman@shell01.TheWorld.com>
Received: from TheWorld.com (pcls2.std.com [192.74.137.142])
	by ozlabs.org (Postfix) with ESMTP id C350CDDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 14:40:59 +1000 (EST)
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200708020440.l724edCT290676@shell01.TheWorld.com>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
To: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 2 Aug 2007 00:40:39 -0400 (EDT)
In-Reply-To: <46B03561.9090800@genesi-usa.com> from "Matt Sealey" at Aug 01,
	2007 08:25:21 AM
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

Matt Sealey writes the following:
>
>Yeah please do a fixup for the boot wrapper.
>
>Or, if you have trouble, go into the firmware and type "nvedit", add
>these lines;
>
>" /isa/8042" find-device
>" 8042" encode-string device-type
>
>(then ctrl-c to exit and nvstore to run it on next reboot. Try it without
>the patch first, on the firmware console, just to be sure I got it right,
>because I can't test it here)

It works from the ok prompt but in the nvramrc it doesn't find the device.
(pci/isa nodes not created yet?)

But the larger point:

>
>You don't need to patch Linux at all. In fact for silly things like this
>I would recommend against it :)

If the workaround doesn't go into the kernel, everybody with affected
hardware has to individually find out about the bug (probably by experiencing
an annoying keyboardless boot) and fix it himself. Is that worth the
reduction in kernel clutter?

-- 
Alan Curry
pacman@world.std.com
