Return-Path: <ddstreet@gmail.com>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 085531A08FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 00:48:28 +1000 (AEST)
Received: by iedfl3 with SMTP id fl3so85601599ied.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2015 07:48:25 -0700 (PDT)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <20150408141631.GB30338@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1428428070-17803-12-git-send-email-ddstreet@ieee.org>
 <20150408141631.GB30338@gondor.apana.org.au>
From: Dan Streetman <ddstreet@ieee.org>
Date: Wed, 8 Apr 2015 10:48:03 -0400
Message-ID: <CALZtONB371ODDyhAVxgaGtxMWRSgshaXsYB8P_5AwSmdiJaAQg@mail.gmail.com>
Subject: Re: [PATCH 11/11] crypto: add crypto compression sefltest
To: Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: "David S. Miller" <davem@davemloft.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, Robert Jennings <rob@pochix.net>,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Seth Jennings <sjennings@variantweb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 8, 2015 at 10:16 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Apr 07, 2015 at 01:34:30PM -0400, Dan Streetman wrote:
>> Add configurable module to perform self-tests on any crypto compression
>> driver.
>>
>> This allows testing any crypto compression driver with any input buffer,
>> at varying alignments and lengths.  It calculates the average bytes per
>> second compression and decompression rates.  Any errors reported by the
>> compressor during compression or decompression will end the test and
>> be logged.
>>
>> Signed-off-by: Dan Streetman <ddstreet@ieee.org>
>
> Please use the existing infrastructure in testmgr/tcrypt.

I think I looked at that and it didn't seem like it would be able to
include all the user controls, but I'll look again.  In any case this
test doesn't have to be included in this 842 patch set, so I'll drop
it from the next version and re-send it by itself if/when I can update
it to use testmgr.

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
