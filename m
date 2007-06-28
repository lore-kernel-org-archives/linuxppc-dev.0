Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1920DDDF82
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 18:44:58 +1000 (EST)
In-Reply-To: <20070627065458.60C5ADDF2B@ozlabs.org>
References: <20070627065458.60C5ADDF2B@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a4f3b70262861ea3823491ef61dffac0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] Make more OF-related bootwrapper functions available
	to non-OF platforms
Date: Thu, 28 Jun 2007 10:44:46 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Commit 2e6016133755eb3cc44e8efab92573d23ed75888 split up
> arch/powerpc/boot/of.c so that some OF functions can be used on
> platforms that don't want to use the overall OF platform boot code.
> This is useful on things like PReP which can have an OF implementation
> which is useful for debugging output, but inadequate for booting.
>
> However, that commit didn't export quite enough things to make a
> usable OF console on a non-OF system.  In particular, the device tree
> manipulation performed to initialize the OF console code must
> explicitly use the OF device tree, rather than the flattened device
> tree, even if the system is otherwise booting using a flattened device
> tree.  This patch makes it so.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Looks good to me, I assume you tested it?  You didn't
mention on what hardware...


Segher
