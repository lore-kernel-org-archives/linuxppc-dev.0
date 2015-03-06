Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 002401A0358
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 23:02:34 +1100 (AEDT)
Date: Fri, 6 Mar 2015 23:02:22 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH v2 2/5] crypto: talitos: Remove MD5_BLOCK_SIZE
Message-ID: <20150306120222.GA5599@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305180726.6ab76042f99af0eb62b64ed6@freescale.com>
Cc: mort@bork.org, linux-crypto@vger.kernel.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, horia.geanta@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kim Phillips <kim.phillips@freescale.com> wrote:
> On Tue,  3 Mar 2015 08:21:34 -0500
> Martin Hicks <mort@bork.org> wrote:
> 
>> This is properly defined in the md5 header file.
>> 
>> Signed-off-by: Martin Hicks <mort@bork.org>
>> ---
> 
> Acked-by: Kim Phillips <kim.phillips@freescale.com>

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
