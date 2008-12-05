Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF515DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 22:11:33 +1100 (EST)
Subject: Re: [PATCH] powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts
	file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081205060835.46c6df7a@zod.rchland.ibm.com>
References: <1228457332-523-1-git-send-email-sr@denx.de>
	<20081205060835.46c6df7a@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 05 Dec 2008 22:11:21 +1100
Message-Id: <1228475481.10722.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-12-05 at 06:08 -0500, Josh Boyer wrote:
> Shouldn't there also be a next-level-cache property added to the cpu
> node that references this?
> 
It would be nice indeed, it would allow the kernel to expose the cache
info in sysfs

Cheers,
Ben.
