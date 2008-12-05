Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 04D71DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 22:17:26 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts
	file
Date: Fri, 5 Dec 2008 12:17:11 +0100
References: <1228457332-523-1-git-send-email-sr@denx.de>
	<20081205060835.46c6df7a@zod.rchland.ibm.com>
	<1228475481.10722.12.camel@pasglop>
In-Reply-To: <1228475481.10722.12.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200812051217.12187.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 05 December 2008, Benjamin Herrenschmidt wrote:
> On Fri, 2008-12-05 at 06:08 -0500, Josh Boyer wrote:
> > Shouldn't there also be a next-level-cache property added to the cpu
> > node that references this?
>
> It would be nice indeed, it would allow the kernel to expose the cache
> info in sysfs

OK, I'll send an updated version in a short while (lunch time first :)).

Best regards,
Stefan
