Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpM2B2gzLzDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 09:37:06 +1000 (AEST)
Date: Tue, 12 Jul 2016 09:37:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Leonidas S. Barbosa"
 <leosilva@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Paul Mackerras <paulus@samba.org>, "open list:IBM Power VMX Cryptographic
 instructions" <linux-crypto@vger.kernel.org>, "open list:LINUX FOR POWERPC
 32-BIT AND 64-BIT" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH 1/2] crypto: vmx - Adding asm subroutines for XTS
Message-ID: <20160712093705.6f0fde7a@canb.auug.org.au>
In-Reply-To: <1468264060-22769-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
References: <1468264060-22769-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
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

Hi Paulo,

On Mon, 11 Jul 2016 16:07:39 -0300 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:
>
> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
> index 2280539..813ffcc 100644
> --- a/drivers/crypto/vmx/aesp8-ppc.pl
> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
> @@ -1,4 +1,11 @@
> -#!/usr/bin/env perl
> +#! /usr/bin/env perl
> +# Copyright 2014-2016 The OpenSSL Project Authors. All Rights Reserved.
> +#
> +# Licensed under the OpenSSL license (the "License").  You may not use
> +# this file except in compliance with the License.  You can obtain a copy
> +# in the file LICENSE in the source distribution or at
> +# https://www.openssl.org/source/license.html

So, I assume that this license is compatible with the GPLv2?

-- 
Cheers,
Stephen Rothwell
