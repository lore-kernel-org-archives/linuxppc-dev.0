Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E963AB7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:48:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C1B4DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:48:36 +1000 (EST)
Message-Id: <068D6265-266F-4EB1-A61A-62F13C8C074D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090723055955.757B4DDD1B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 9/20] powerpc/mm: Call mmu_context_init() from ppc64
Date: Thu, 23 Jul 2009 09:48:29 -0500
References: <20090723055955.757B4DDD1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2009, at 12:59 AM, Benjamin Herrenschmidt wrote:

> Our 64-bit hash context handling has no init function, but 64-bit  
> Book3E
> will use the common mmu_context_nohash.c code which does, so define an
> empty inline mmu_context_init() for 64-bit server and call it from
> our 64-bit setup_arch()
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> arch/powerpc/include/asm/mmu_context.h |    7 ++++++-
> arch/powerpc/kernel/setup_64.c         |    4 ++++
> arch/powerpc/mm/mmu_context_hash64.c   |    1 +
> 3 files changed, 11 insertions(+), 1 deletion(-)


Acked-by: Kumar Gala <galak@kernel.crashing.org>

(w/the assumption the respin will just change the whitespace issue).

- k
