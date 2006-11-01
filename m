Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C765667A3A
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 01:50:53 +1100 (EST)
Date: Wed, 1 Nov 2006 06:50:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Eliminate "exceeds stub group size" linker
	warning
In-Reply-To: <17735.61916.194247.973705@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0611010647040.25218@g5.osdl.org>
References: <17735.61916.194247.973705@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 1 Nov 2006, Paul Mackerras wrote:
> 
> If you think this is 2.6.19 material, feel free to put it in your
> tree.  Otherwise I'll put it in the powerpc.git tree to go in for
> 2.6.20.

Hmm. I'd love to get rid of the warnings, because they obviously mean that 
I don't look at warnings much at all ("they're all bogus"), but this patch 
must be against some version of arch/powerpc/kernel/head_64.S that I've 
never seen.

That "do_stab_bolted_pSeries" function is in a totally different place for 
me, and the index that git diff mentiones of 47fcff1 doesn't exist in my 
tree (so I've literally never had it).

		Linus
