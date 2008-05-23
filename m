Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 15968DE527
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 00:25:12 +1000 (EST)
Date: Fri, 23 May 2008 09:42:21 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 02/12] pasemi-rng: use linux/of_platform.h instead of asm
Message-ID: <20080523144221.GA2061@lixom.net>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162005.5b893a90.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080523162005.5b893a90.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 04:20:05PM +1000, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Olof Johansson <olof@lixom.net>

> ---
>  drivers/char/hw_random/pasemi-rng.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
