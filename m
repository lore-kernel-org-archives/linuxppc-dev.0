Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqMkR4bJFzDqFZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 01:11:59 +1000 (AEST)
Date: Thu, 14 Jul 2016 01:11:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, "Leonidas S. Barbosa"
 <leosilva@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, "open
 list:IBM Power VMX Cryptographic instructions"
 <linux-crypto@vger.kernel.org>, "open list:LINUX FOR POWERPC 32-BIT AND
 64-BIT" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH 1/2] crypto: vmx - Adding asm subroutines for XTS
Message-ID: <20160714011158.46c386f4@canb.auug.org.au>
In-Reply-To: <20160713133427.GA20432@dublin>
References: <1468264060-22769-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
 <20160712093705.6f0fde7a@canb.auug.org.au>
 <8737nep7a8.fsf@linux.vnet.ibm.com> <20160713133427.GA20432@dublin>
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

On Wed, 13 Jul 2016 10:34:27 -0300 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:
>
> Wed, Jul 13, 2016 at 01:05:03PM +1000, Stewart Smith wrote:
> > Stephen Rothwell <sfr@canb.auug.org.au> writes:  
> > > On Mon, 11 Jul 2016 16:07:39 -0300 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:  
> > >>
> > >> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
> > >> index 2280539..813ffcc 100644
> > >> --- a/drivers/crypto/vmx/aesp8-ppc.pl
> > >> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
> > >> @@ -1,4 +1,11 @@
> > >> -#!/usr/bin/env perl
> > >> +#! /usr/bin/env perl
> > >> +# Copyright 2014-2016 The OpenSSL Project Authors. All Rights Reserved.
> > >> +#
> > >> +# Licensed under the OpenSSL license (the "License").  You may not use
> > >> +# this file except in compliance with the License.  You can obtain a copy
> > >> +# in the file LICENSE in the source distribution or at
> > >> +# https://www.openssl.org/source/license.html  
> > >
> > > So, I assume that this license is compatible with the GPLv2?  
> 
> Andy released this code under the cryptogams license:
> 
> # ====================================================================
> # Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
> # project. The module is, however, dual licensed under OpenSSL and
> # CRYPTOGAMS licenses depending on where you obtain it. For further
> # details see http://www.openssl.org/~appro/cryptogams/.
> # ====================================================================

Yeah, this license statement is already in the file being patched, so
why is the above license (and Copyright notice) being added above the
existing one?

> The license is GPL compatible:

Good, thanks.

> ALTERNATIVELY, provided that this notice is retained in full, this
> product may be distributed under the terms of the GNU General Public
> License (GPL), in which case the provisions of the GPL apply INSTEAD OF
> those given above.

Which is not in this file or the patch, but presumably in the referred
to web page.

Of course, I am not a lawyer :-)
-- 
Cheers,
Stephen Rothwell
