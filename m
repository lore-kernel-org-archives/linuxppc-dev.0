Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A73F6DDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 12:47:40 +1100 (EST)
Date: Wed, 11 Feb 2009 17:47:33 -0800 (PST)
Message-Id: <20090211.174733.163367216.davem@davemloft.net>
To: npiggin@suse.de
Subject: Re: next Feb 10: mm/slqb build break
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090212014503.GD30043@wotan.suse.de>
References: <49914EE7.7030205@in.ibm.com>
	<84144f020902100353x4074f342ne4d61483074a06b7@mail.gmail.com>
	<20090212014503.GD30043@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	penberg@cs.helsinki.fi, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nick Piggin <npiggin@suse.de>
Date: Thu, 12 Feb 2009 02:45:03 +0100

> On Tue, Feb 10, 2009 at 01:53:51PM +0200, Pekka Enberg wrote:
> > Actually, that's not the root cause here. You seem to have CONFIG_SMP
> > disabled but CONFIG_NUMA enabled. That's not possible on x86 which
> > makes me think it's a ppc kconfig bug. Hmm?
> 
> If it is really a valid config, then we should be able to make
> slqb build with it...

FWIW I only allow NUMA with SMP on sparc64, just like x86.

Although it seems IA64, like powerpc, does not have this restriction.
Hmmm...
