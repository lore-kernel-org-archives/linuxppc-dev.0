Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-67-162-90-113.hsd1.in.comcast.net
	[67.162.90.113]) by ozlabs.org (Postfix) with SMTP id 45326B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 04:32:30 +1100 (EST)
Message-ID: <20101010173227.2158.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Re: Pegasos i8042 broken again
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 10 Oct 2010 12:32:27 -0500 (GMT+5)
In-Reply-To: <1286696147.2463.499.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
> 
> Those things really suck. They absolutely refuse to fix their FW for
> reasons I never quite managed to figure out.

The last time around, they did release a firmware patch (pegasos-dts-20071018)
to fix up the device tree enough to satisfy the kernel. Now that the kernel
has become dissatisfied again, maybe another patch will appear.

> 
> At this stage, I'd say the best is to add yet another pegasos workaround
> in prom_init that adds the missing compatible property.

This one would be more complex than the other fixes in prom_init. It's not
just the compatible property that's missing. The 8042 node in the device tree
has no children.

-- 
Alan Curry
