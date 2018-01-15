Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKq504MnvzF0T8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 21:16:20 +1100 (AEDT)
In-Reply-To: <20180110061014.29181-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc: Don't preempt_disable() in show_cpuinfo()
Message-Id: <3zKq4z1Cbcz9sCZ@ozlabs.org>
Date: Mon, 15 Jan 2018 21:16:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-10 at 06:10:12 UTC, Benjamin Herrenschmidt wrote:
> This causes warnings from cpufreq mutex code. This is also
> rather unnecessary and ineffective. If we really want to
> prevent concurrent unplug, we could take the unplug read
> lock but I don't see this being critical.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/349524bc0da698ec77f2057cf4a494

cheers
