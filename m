Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F86A1A06F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:28:26 +1100 (AEDT)
Date: Wed, 26 Nov 2014 17:28:19 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
Message-ID: <20141126232819.GB6567@gate.crashing.org>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia>
 <20141126232318.GA6567@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141126232318.GA6567@gate.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 05:23:18PM -0600, Segher Boessenkool wrote:
> GCC has added -many to the assembler flags for over ten years now, so
> no that will not work.  You can use -mppc or similar with the assembler
> if you invoke it correctly (use  $(CC) -print-prog-name=as  to figure
s/correctly/directly/
> out how to call the assembler, if you want to stay sane and use the
> same one as the rest of the toolchain you use).
> 
> 
> Segher
