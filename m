Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id ECDA8DE137
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 00:20:50 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc4xx_pci: necessary fixes for 4GB RAM size
Date: Thu, 28 Aug 2008 16:18:31 +0200
References: <1219391015-6317-1-git-send-email-yanok@emcraft.com>
	<20080828092820.2cacaba7@zod.rchland.ibm.com>
In-Reply-To: <20080828092820.2cacaba7@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281618.31652.sr@denx.de>
Cc: wd@denx.de, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008, Josh Boyer wrote:
> > 1. total_memory should be phys_addr_t not unsigned long
> > 2. is_power_of_2() works with u32 so I just inlined (size & (size-1)) !=
> > 0 instead.
> > Also this patch fixes default initialization: res->end should be
> > 0x7fffffff not 0x80000000.
> >
> > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>
> Ben, any comments here?  Looks right to me.

Looks good to me too. So:

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
