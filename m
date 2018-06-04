Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgj3T8mzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:29 +1000 (AEST)
In-Reply-To: <20180530121922.22122-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5,
 2/4] powerpc/kbuild: remove CROSS32 defines from top level powerpc
 Makefile
Message-Id: <40zxgh6WhFz9s08@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 12:19:20 UTC, Nicholas Piggin wrote:
> Switch VDSO32 build over to use CROSS32_COMPILE directly, and have
> it pass in -m32 after the standard c_flags. This allows endianness
> overrides to be removed and the endian and bitness flags moved into
> standard flags variables.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/af3901cbbd3de182aafb8ee553c825

cheers
