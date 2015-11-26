Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FC7B1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:53 +1100 (AEDT)
In-Reply-To: <1446723094-9910-1-git-send-email-laurent@vivier.eu>
To: Laurent Vivier <laurent@vivier.eu>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: powerpc/boot: allow wrapper to work on non-english system
Message-Id: <20151126121553.8A5D0140311@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-11 at 11:31:34 UTC, Laurent Vivier wrote:
> if the language is not english objdump output is not parsed correctly
> and format is "". Later, "ld -m $format" fails.
> 
> This patch adds "LANG=C" to force english output for objdump.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/58531b0c800fd514f04ae42b

cheers
