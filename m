Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7XZw4Kn1zDqgS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 08:46:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] crypto: powerpc - CRYPT_CRC32C_VPMSUM should depend on
 ALTIVEC
In-Reply-To: <20160808152422.GA31570@gondor.apana.org.au>
References: <1470048886-8899-1-git-send-email-mpe@ellerman.id.au>
 <20160804150048.005f5c02@kryten> <87a8grki7w.fsf@concordia.ellerman.id.au>
 <20160808152422.GA31570@gondor.apana.org.au>
Date: Tue, 09 Aug 2016 08:46:31 +1000
Message-ID: <87h9auswu0.fsf@concordia.ellerman.id.au>
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

> On Fri, Aug 05, 2016 at 01:28:03PM +1000, Michael Ellerman wrote:
>> Anton Blanchard <anton@samba.org> writes:
>> 
>> > Hi Michael,
>> >
>> >> The optimised crc32c implementation depends on VMX (aka. Altivec)
>> >> instructions, so the kernel must be built with Altivec support in
>> >> order for the crc32c code to build.
>> >
>> > Thanks for that, looks good.
>> >
>> > Acked-by: Anton Blanchard <anton@samba.org>
>> 
>> Thanks. Herbert, expecting you'll pick this up.
>
> In that case Anton can you please post it to linux-crypto?

Sorry that's my fault, will repost to linux-crypto.

cheers
