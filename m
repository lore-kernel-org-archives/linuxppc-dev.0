Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9CC31A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 20:17:50 +1100 (AEDT)
Date: Wed, 4 Mar 2015 22:17:38 +1300
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Markus Stockhausen <stockhausen@collogia.de>
Subject: Re: [v1,1/3] crypto: powerpc/md5 - assembler
Message-ID: <20150304091738.GA9268@gondor.apana.org.au>
References: <dfab72c4-908c-43ce-bb28-480afc0c9536@EXCHANGE.collogia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dfab72c4-908c-43ce-bb28-480afc0c9536@EXCHANGE.collogia.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 01, 2015 at 07:30:35PM +0100, Markus Stockhausen wrote:
> This is the assembler code for the MD5 implementation.
> Handling of algorithm constants has been slightly
> changed to reduce register usage and make better use
> of cores with multiple ALUs. Thus they are stored as
> delta values.
> 
> Signed-off-by: Markus Stockhausen <stockhausen@collogia.de>

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
