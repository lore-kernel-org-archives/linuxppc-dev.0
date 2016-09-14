Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYl3D1cpgzDsZd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 11:54:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: olof@lixom.net, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 mpm@selenic.com
Subject: Re: [PATCH] hwrng: pasemi-rng - Use linux/io.h instead of asm/io.h
In-Reply-To: <20160913123919.GA31835@gondor.apana.org.au>
References: <1473150519-30931-1-git-send-email-prasannatsmkumar@gmail.com>
 <20160913123919.GA31835@gondor.apana.org.au>
Date: Wed, 14 Sep 2016 11:54:31 +1000
Message-ID: <87y42vnt48.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Tue, Sep 06, 2016 at 01:58:39PM +0530, PrasannaKumar Muralidharan wrote:
>> Checkpatch.pl warns about usage of asm/io.h. Use linux/io.h instead.
>> 
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>
> Patch applied.  Thanks.

Oops I merged it too, my bad.

Hopefully git will work out the resolution.

cheers
