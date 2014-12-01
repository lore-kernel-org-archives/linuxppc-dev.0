Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8CA1A0612
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 11:58:18 +1100 (AEDT)
Message-ID: <1417395497.16178.0.camel@concordia>
Subject: Re: [PATCH 6/8 v2] crypto: replace memset by memzero_explicit
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 01 Dec 2014 11:58:17 +1100
In-Reply-To: <1417367029-32762-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1417367029-32762-1-git-send-email-Julia.Lawall@lip6.fr>
 <1417367029-32762-7-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Herbert Xu <herbert@gondor.apana.org.au>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-11-30 at 18:03 +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Memset on a local variable may be removed when it is called just before the
> variable goes out of scope.  Using memzero_explicit defeats this
> optimization.  A simplified version of the semantic patch that makes this
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> Daniel Borkmann suggested that these patches could go through Herbert Xu's
> cryptodev tree.

That's fine by me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
