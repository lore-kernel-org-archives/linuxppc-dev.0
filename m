Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3FDBFDDEE7
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:18:41 +1100 (EST)
Date: Fri, 24 Oct 2008 16:18:18 -0700 (PDT)
Message-Id: <20081024.161818.256978293.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: default IRQ affinity change in v2.6.27 (breaking several SMP
	PPC based systems)
From: David Miller <davem@davemloft.net>
In-Reply-To: <36A821E7-7F37-42AF-9A05-7205FCBF89EE@kernel.crashing.org>
References: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>
	<4901E6FB.4070200@redhat.com>
	<36A821E7-7F37-42AF-9A05-7205FCBF89EE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, csnook@redhat.com,
	linux-kernel@vger.kernel.org, maxk@qualcomm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 24 Oct 2008 10:39:05 -0500

> As for making it ARCH specific, that doesn't really help since not
> all PPC hw has the limitation I spoke of.  Not even all MPIC (in our
> cases) have the limitation.

Since the PPC code knows exactly which MPICs have the problem the
PPC code is where the constraining can occur.

I agree completely with the suggestion that the arch code has to
interpret the cpumask as appropriate for the hardware, since the
user can stick "illegal" values there anyways.
