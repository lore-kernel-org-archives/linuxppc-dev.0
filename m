Return-Path: <srs0=ijit=j2=lwn.net=corbet@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QFLf4f8mzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 07:14:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41QFLf3w6dz8tdC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 07:14:02 +1000 (AEST)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41QFLf1h29z9s0W
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2018 07:14:01 +1000 (AEST)
Date: Tue, 10 Jul 2018 15:13:56 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: keescook@chromium.org, tglx@linutronix.de, konrad.wilk@oracle.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Documentation: Add powerpc options for
 spec_store_bypass_disable
Message-ID: <20180710151356.10c4834e@lwn.net>
In-Reply-To: <20180710020836.23571-1-mpe@ellerman.id.au>
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

On Tue, 10 Jul 2018 12:08:36 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Document the support for spec_store_bypass_disable that was added for
> powerpc in commit a048a07d7f45 ("powerpc/64s: Add support for a store
> forwarding barrier at kernel entry/exit").
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied, thanks.

jon
