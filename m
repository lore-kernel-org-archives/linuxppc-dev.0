Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7ngz0mLGzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 15:37:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, herbert@gondor.apana.org.au
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/crypto/crct10dif-vpmsum: Fix missing
 preempt_disable()
In-Reply-To: <877f2gaqhq.fsf@possimpible.ozlabs.ibm.com>
References: <1492578458-26252-1-git-send-email-mpe@ellerman.id.au>
 <877f2gaqhq.fsf@possimpible.ozlabs.ibm.com>
Date: Thu, 20 Apr 2017 15:37:34 +1000
Message-ID: <87vapz4p29.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> Hi Michael,
>
>> Fixes: b01df1c16c9a ("crypto: powerpc - Add CRC-T10DIF acceleration")
>
> Thank you very much for doing this! (and my apologies for not doing it
> myself!)

No worries, the enable_altivec() API is ridiculous, I'm surprised we
ever get it right.

> It all looks good to me.
>
> I think an Ack is appropriate in these circumstances?
> Acked-by: Daniel Axtens <dja@axtens.net>

Thanks I've added that to v2.

cheers
