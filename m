Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDnd3WlczF13T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 20:01:25 +1000 (AEST)
In-Reply-To: <20180514125033.12000-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alistair@popple.id.au, paulus@samba.org
Subject: Re: [1/3] powerpc/io: Add __raw_writeq_be() __raw_rm_writeq_be()
Message-Id: <40qDnd0rtdz9s3D@ozlabs.org>
Date: Mon, 21 May 2018 20:01:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 12:50:31 UTC, Michael Ellerman wrote:
> Add byte-swapping versions of __raw_writeq() and __raw_rm_writeq().
> 
> This allows us to avoid sparse warnings caused by passing __be64 to
> __raw_writeq(), which takes unsigned long:
> 
>   arch/powerpc/platforms/powernv/pci-ioda.c:1981:38:
>   warning: incorrect type in argument 1 (different base types)
>       expected unsigned long [unsigned] v
>       got restricted __be64 [usertype] <noident>
> 
> It's also generally preferable to use a byte-swapping accessor rather
> than doing it by hand in the code, which is more bug prone.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/8056fe28d04607106e7d418bd9ee2e

cheers
