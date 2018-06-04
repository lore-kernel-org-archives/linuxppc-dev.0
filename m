Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgg3RC4zF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:27 +1000 (AEST)
In-Reply-To: <20180530121922.22122-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5,
 3/4] powerpc/kbuild: Use flags variables rather than overriding
 LD/CC/AS
Message-Id: <40zxgf2gKKz9s7Y@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 12:19:21 UTC, Nicholas Piggin wrote:
> The powerpc toolchain can compile combinations of 32/64 bit and
> big/little endian, so it's convenient to consider, e.g.,
> 
>   `CC -m64 -mbig-endian`
> 
> To be the C compiler for the purpose of invoking it to build target
> artifacts. So overriding the the CC variable to include thse flags
> works for this purpose.
> 
> Unfortunately that is not compatible with the way the proposed new
> Kconfig macro language will work.
> 
> After previous patches in this series, these flags can be carefully
> passed in using flags instead.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1421dc6d48296a9e91702743b31458

cheers
