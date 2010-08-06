Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E743B6EE8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 16:25:55 +1000 (EST)
Subject: Re: [PATCH] powerpc: inline ppc64_runlatch_off
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100806055640.GS29316@kryten>
References: <20100806045315.GR29316@kryten>
	<1281071865.2168.28.camel@pasglop>  <20100806055640.GS29316@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Aug 2010 16:25:49 +1000
Message-ID: <1281075949.2168.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-08-06 at 15:56 +1000, Anton Blanchard wrote:
> Unfortunately we still need to prevent continual writes to it with a per thread
> flag because on some CPUs a write to the SPR in low priority mode will stall
> another SMT thread. So we could get rid of the cpu feature comparison but
> we would still need the thread bit check (or perhaps replace it with a per cpu
> variable). 

remind me why we need to do that runlatch thing on these CPUs at all ?

Cheers,
Ben.
