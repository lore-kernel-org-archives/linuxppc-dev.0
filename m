Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id D6509DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 08:05:00 +1100 (EST)
Date: Fri, 5 Dec 2008 15:04:48 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts
	file
Message-ID: <20081205210448.GE6958@localdomain>
References: <1228457332-523-1-git-send-email-sr@denx.de>
	<20081205060835.46c6df7a@zod.rchland.ibm.com>
	<1228475481.10722.12.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228475481.10722.12.camel@pasglop>
Cc: Roese <sr@denx.de>, linuxppc-dev@ozlabs.org, Stefan
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2008-12-05 at 06:08 -0500, Josh Boyer wrote:
> > Shouldn't there also be a next-level-cache property added to the cpu
> > node that references this?
> > 
> It would be nice indeed, it would allow the kernel to expose the cache
> info in sysfs

Currently the kernel only knows about the 'l2-cache' property and not
'next-level-cache'.  I've got patches to fix that, will post them
soon.
