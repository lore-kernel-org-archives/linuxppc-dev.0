Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qfsy2vg3zDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:06 +1000 (AEST)
In-Reply-To: <1511897374-27408-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: scripts: Add ppc64le support for checkstack.pl
Message-Id: <41Qfsw3GCDzB4MP@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-28 at 19:29:34 UTC, Breno Leitao wrote:
> 64-bit ELF v2 ABI specification for POWER describes, on section "General
> Stack Frame Requirements", that the stack should use the following
> instructions when compiled with backchain:
> 
>   mflr r0
>   std  r0, 16(r1)
>   stdu r1, -XX(r1)
> 
> Where XX is the frame size for that function, and this is the value
> checkstack.pl will find the stack size for each function.
> 
> This patch also simplifies the entire Powerpc section, since just two
> type of instructions are used, 'stdu' for 64 bits and 'stwu' for 32 bits
> platform.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8449a4cb69ab6fbb873d653a82787a

cheers
