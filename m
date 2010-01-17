Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 6969CB7CE6
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jan 2010 08:43:44 +1100 (EST)
Date: Sun, 17 Jan 2010 22:43:40 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH] trivial: fix typo s/leve/level/ in powerpc arch
In-Reply-To: <1263763394-9572-1-git-send-email-cascardo@holoscopio.com>
Message-ID: <alpine.LNX.2.00.1001172243310.30977@pobox.suse.cz>
References: <1263763394-9572-1-git-send-email-cascardo@holoscopio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 17 Jan 2010, Thadeu Lima de Souza Cascardo wrote:

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> ---
>  arch/powerpc/mm/tlb_low_64e.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index f288279..8b04c54 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -1,5 +1,5 @@
>  /*
> - *  Low leve TLB miss handlers for Book3E
> + *  Low level TLB miss handlers for Book3E
>   *
>   *  Copyright (C) 2008-2009
>   *      Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.

Applied to trivial queue, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
