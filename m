Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 628EF1A0EA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 22:18:48 +1000 (AEST)
Message-ID: <1438258721.27001.3.camel@ellerman.id.au>
Subject: Re: [PATCH -v2 6/8] jump_label: Add a new static_key interface
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jasonbaron0@gmail.com,
 bp@alien8.de, luto@amacapital.net, tglx@linutronix.de, rostedt@goodmis.org,
 will.deacon@arm.com, liuj97@gmail.com, rabin@rab.in, ralf@linux-mips.org,
 ddaney@caviumnetworks.com, benh@kernel.crashing.org,
 heiko.carstens@de.ibm.com,  davem@davemloft.net, vbabka@suse.cz,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Thu, 30 Jul 2015 22:18:41 +1000
In-Reply-To: <20150728132313.164884020@infradead.org>
References: <20150728132055.203176565@infradead.org>
 <20150728132313.164884020@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-28 at 15:21 +0200, Peter Zijlstra wrote:
> There are various problems and short-comings with the current
> static_key interface:
...
> ---
>  arch/powerpc/include/asm/jump_label.h |   19 ++++

This looks sane and seems to be working, so powerpc bits:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
