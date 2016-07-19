Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rthZr1432zDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 11:01:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>, alastair@au1.ibm.com
Cc: benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 0/2] Automatically load the vmx_crypto module if supported
In-Reply-To: <20160718102253.GA13780@gondor.apana.org.au>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
 <20160718102253.GA13780@gondor.apana.org.au>
Date: Tue, 19 Jul 2016 11:01:55 +1000
Message-ID: <87fur6phj0.fsf@@concordia.ellerman.id.au>
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

> On Wed, Jul 13, 2016 at 03:47:16PM +1000, alastair@au1.ibm.com wrote:
>> From: Alastair D'Silva <alastair@d-silva.org>
>> 
>> This series allows the vmx_crypto module to be detected and automatically
>> loaded via UDEV if the CPU supports the vector crypto feature.
>> 
>> Alastair D'Silva (2):
>>   powerpc: Add module autoloading based on CPU features
>>   crypto: vmx - Convert to CPU feature based module autoloading
>
> Both patches applied.  Thanks.

Hi Herbert,

Can you please ask for an ack before merging arch patches?

That's a 70 line powerpc patch and a 6 line crypto patch. It has no
reviews and no acks. I would have preferred it if we could take it via
the powerpc tree.

cheers
