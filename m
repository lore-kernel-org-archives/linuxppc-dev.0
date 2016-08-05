Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5C1f1vzbzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 13:28:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: herbert@gondor.apana.org.au, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] crypto: powerpc - CRYPT_CRC32C_VPMSUM should depend on
 ALTIVEC
In-Reply-To: <20160804150048.005f5c02@kryten>
References: <1470048886-8899-1-git-send-email-mpe@ellerman.id.au>
 <20160804150048.005f5c02@kryten>
Date: Fri, 05 Aug 2016 13:28:03 +1000
Message-ID: <87a8grki7w.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@samba.org> writes:

> Hi Michael,
>
>> The optimised crc32c implementation depends on VMX (aka. Altivec)
>> instructions, so the kernel must be built with Altivec support in
>> order for the crc32c code to build.
>
> Thanks for that, looks good.
>
> Acked-by: Anton Blanchard <anton@samba.org>

Thanks. Herbert, expecting you'll pick this up.

cheers
