Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7EBFDDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 21:47:32 +1000 (EST)
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <200710181500.32288.yur@emcraft.com>
References: <200710181500.32288.yur@emcraft.com>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 21:47:18 +1000
Message-Id: <1192708038.12879.54.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-18 at 15:00 +0400, Yuri Tikhonov wrote:
> It has turned out that my mailer had corrupted my previous message (thanks
> Wolfgang Denk for pointing this). So if you'd like to apply the patch without the
> conflicts please use the version of the patch in this mail.
> 
>  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> built using the modified version of binutils, where the MAXPAGESIZE 
> definition is set to 0x40000 (as opposite to standard 0x10000).
> 
>  Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>
>  Acked-by: Yuri Tikhonov <yur@emcraft.com>

Small nit...

You are posting the patch, thus you should be signing off, not ack'ing.

Ack'ing means you agree with the patch but you aren't in the handling
chain for it. In this case, it seems like the author is Pavel and you
are forwarding it, in wich case, you -are- in the handling chain and
should should sign it off.

Best would be for Pavel (if he is indeed the author) to submit it
himself though.

Ben.
