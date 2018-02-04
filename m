Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yK5LcvzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yK1fSqz8sxQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:17 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yJ0xh3z9t42
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:15 +1100 (AEDT)
Date: Sun, 4 Feb 2018 12:07:17 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 16/16] powerpc/64s: Allow control of RFI
 flush via debugfs
Message-ID: <20180204110717.GK7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-17-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-17-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:10PM +1100, Michael Ellerman wrote:
> commit 236003e6b5443c45c18e613d2b0d776a9f87540e upstream.
> 
> Expose the state of the RFI flush (enabled/disabled) via debugfs, and
> allow it to be enabled/disabled at runtime.
> 
> eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
>     1
>     $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
>     $ cat /sys/kernel/debug/powerpc/rfi_flush
>     0
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Also applied to 4.9.y and 4.14.y, thanks.

greg k-h
