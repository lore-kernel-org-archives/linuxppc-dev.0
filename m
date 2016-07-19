Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtvV05vh7zDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 19:13:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: alastair@au1.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 0/2] Automatically load the vmx_crypto module if supported
In-Reply-To: <20160719035939.GA20847@gondor.apana.org.au>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
 <20160718102253.GA13780@gondor.apana.org.au>
 <87fur6phj0.fsf@@concordia.ellerman.id.au>
 <20160719035939.GA20847@gondor.apana.org.au>
Date: Tue, 19 Jul 2016 19:13:24 +1000
Message-ID: <87poqa9eiz.fsf@@concordia.ellerman.id.au>
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

> On Tue, Jul 19, 2016 at 11:01:55AM +1000, Michael Ellerman wrote:
>>
>> Can you please ask for an ack before merging arch patches?
>> 
>> That's a 70 line powerpc patch and a 6 line crypto patch. It has no
>> reviews and no acks. I would have preferred it if we could take it via
>> the powerpc tree.
>
> Sorry, I'll delete them from the crypto tree.

Thanks.

I'll assume patch 2 has your ack :)

cheers
