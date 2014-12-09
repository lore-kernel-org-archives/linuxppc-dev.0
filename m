Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 763A21A0588
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:06:17 +1100 (AEDT)
In-Reply-To: <20141208141629.912861A5D5B@localhost.localdomain>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc32: missing accessors to pgprot_t objects
Message-Id: <20141209100617.630111400EA@ozlabs.org>
Date: Tue,  9 Dec 2014 21:06:17 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-12 at 14:16:29 UTC, LEROY Christophe wrote:
> Compilation with #define STRICT_MM_TYPECHECKS in arch/powerpc/include/asm/page.h
> fails due to missing use of pgprot_val() when using pgprot_t objects.

Any idea when this broke? Recently, or has it gone unnoticed for a long time?

cheers
