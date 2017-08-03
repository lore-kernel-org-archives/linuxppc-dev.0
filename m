Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNQz11sZ3zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 20:19:41 +1000 (AEST)
In-Reply-To: <20170729195217.214940504@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: mpc832x_rdb: fix of_irq_to_resource() error check
Message-Id: <3xNQz034xCz9s9Y@ozlabs.org>
Date: Thu,  3 Aug 2017 20:19:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-07-29 at 19:52:09 UTC, Sergei Shtylyov wrote:
> of_irq_to_resource() has recently been  fixed to return negative error #'s
> along with 0 in case of failure,  however the Freescale MPC832x RDB board
> code still only regards 0 as as failure indication -- fix it up.
> 
> Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Scott Wood <oss@buserror.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f29bb7861a5107cc1afbf5a565c310

cheers
