Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yG16wYzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yF1kNKz8wFn
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:13 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yD5Tcxz9t2x
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:11 +1100 (AEDT)
Date: Sun, 4 Feb 2018 11:53:55 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 06/16] powerpc/64: Add macros for
 annotating the destination of rfid/hrfid
Message-ID: <20180204105355.GE7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-7-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-7-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:00PM +1100, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> commit 50e51c13b3822d14ff6df4279423e4b7b2269bc3 upstream.
> 
> The rfid/hrfid ((Hypervisor) Return From Interrupt) instruction is
> used for switching from the kernel to userspace, and from the
> hypervisor to the guest kernel. However it can and is also used for
> other transitions, eg. from real mode kernel code to virtual mode
> kernel code, and it's not always clear from the code what the
> destination context is.
> 
> To make it clearer when reading the code, add macros which encode the
> expected destination context.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Also applied to 4.9.y, thanks.

greg k-h
