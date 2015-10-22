Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C1651A0443
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 01:18:27 +1100 (AEDT)
Date: Thu, 22 Oct 2015 16:19:15 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
Subject: Re: [PATCH] powerpc: Introduce the use of the managed version of
 kzalloc
Message-ID: <20151022161915.2b3afe20@crub>
In-Reply-To: <20140526202130.GA16360@himangi-Dell>
References: <20140526202130.GA16360@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 May 2014 01:51:31 +0530
Himangi Saraogi <himangi774@gmail.com> wrote:
...
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
> Not compile tested
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

applied to mpc5xxx/next.

Thanks,

Anatolij
