Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 08280DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 01:23:58 +1000 (EST)
Date: Wed, 15 Aug 2007 10:40:51 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Fix section mismatch in pasemi/iommu.c
Message-ID: <20070815154051.GA16232@lixom.net>
References: <20070815205823.b0a04715.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070815205823.b0a04715.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 15, 2007 at 08:58:23PM +1000, Stephen Rothwell wrote:
> These functions are only called by __init functions.
> 
> WARNING: vmlinux.o(.text+0x56aa0): Section mismatch: reference to .init.text:.lmb_alloc (between '.iob_init' and '.iommu_init_early_pasemi')
> 

Thanks! It was drowning in the other warnings, I'd never noticed it.


> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Olof Johansson <olof@lixom.net>
