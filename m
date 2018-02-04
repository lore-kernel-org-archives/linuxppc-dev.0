Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yK2jNqzDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yJ4xcdz8wFn
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:16 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yJ0xZtz9t3p
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:15 +1100 (AEDT)
Date: Sun, 4 Feb 2018 11:55:24 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 07/16] powerpc/64s: Simple RFI macro
 conversions
Message-ID: <20180204105524.GF7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-8-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-8-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:01PM +1100, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> commit 222f20f140623ef6033491d0103ee0875fe87d35 upstream.
> 
> This commit does simple conversions of rfi/rfid to the new macros that
> include the expected destination context. By simple we mean cases
> where there is a single well known destination context, and it's
> simply a matter of substituting the instruction for the appropriate
> macro.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [Balbir fixed issues with backporting to stable]
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Can you provide a backport to 4.9.y for this?

thanks,

greg k-h
