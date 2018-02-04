Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yG3Y2yzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:14 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yG17BJz8wGq
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:14 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yD6glXz9t42
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:11 +1100 (AEDT)
Date: Sun, 4 Feb 2018 11:52:37 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 05/16] powerpc/pseries: Add
 H_GET_CPU_CHARACTERISTICS flags & wrapper
Message-ID: <20180204105237.GD7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-6-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-6-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 03:59:59PM +1100, Michael Ellerman wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> commit 191eccb1580939fb0d47deb405b82a85b0379070 upstream.
> 
> A new hypervisor call has been defined to communicate various
> characteristics of the CPU to guests. Add definitions for the hcall
> number, flags and a wrapper function.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [Balbir fixed conflicts in backport]
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/hvcall.h         | 17 +++++++++++++++++
>  arch/powerpc/include/asm/plpar_wrappers.h | 14 ++++++++++++++
>  2 files changed, 31 insertions(+)

Also applied to 4.9.y as it was missing from there.

thanks,

greg k-h
