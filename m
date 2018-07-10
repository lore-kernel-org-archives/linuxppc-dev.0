Return-Path: <srs0=jmlf=j2=linutronix.de=tglx@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Psrl0T3WzDrWk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 16:35:19 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41Psrk6tPqz8x9L
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 16:35:18 +1000 (AEST)
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41Psrk3NCpz9s1R
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2018 16:35:17 +1000 (AEST)
Date: Tue, 10 Jul 2018 08:10:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: corbet@lwn.net, keescook@chromium.org, konrad.wilk@oracle.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Documentation: Add powerpc options for
 spec_store_bypass_disable
In-Reply-To: <20180710020836.23571-1-mpe@ellerman.id.au>
Message-ID: <alpine.DEB.2.21.1807100809320.1590@nanos.tec.linutronix.de>
References: <20180710020836.23571-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Jul 2018, Michael Ellerman wrote:

> Document the support for spec_store_bypass_disable that was added for
> powerpc in commit a048a07d7f45 ("powerpc/64s: Add support for a store
> forwarding barrier at kernel entry/exit").
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> I tried documenting the differences between the PPC options and X86 ones in one
> section, but it got quite messy, so I went with this instead. Happy to take
> advice on how better to structure it if anyone has opinions.

Looks good to me.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
