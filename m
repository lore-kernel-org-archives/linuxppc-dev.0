Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E9D31A0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:13:56 +1100 (AEDT)
Message-ID: <1418119994.13358.43.camel@kernel.crashing.org>
Subject: Re: powerpc32: missing accessors to pgprot_t objects
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 09 Dec 2014 21:13:14 +1100
In-Reply-To: <20141209100617.630111400EA@ozlabs.org>
References: <20141209100617.630111400EA@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 21:06 +1100, Michael Ellerman wrote:
> On Mon, 2014-08-12 at 14:16:29 UTC, LEROY Christophe wrote:
> > Compilation with #define STRICT_MM_TYPECHECKS in arch/powerpc/include/asm/page.h
> > fails due to missing use of pgprot_val() when using pgprot_t objects.
> 
> Any idea when this broke? Recently, or has it gone unnoticed for a long time?

Probably a very long time...

Now the reason we didn't leave STRICT_MM_TYPECHECKS enable back in the
day is that gcc was doing a terrible job at compiling it resulting in
bloated inefficient code.

I wouldn't be surprised if that is all fixed...

Cheers,
Ben.
