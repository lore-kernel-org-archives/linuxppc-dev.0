Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 230B3B71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 15:38:57 +1000 (EST)
Subject: Re: linux-next: manual merge of the tip tree with the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110520141425.dd38cb7d.sfr@canb.auug.org.au>
References: <20110520141425.dd38cb7d.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 15:38:24 +1000
Message-ID: <1305869904.7481.145.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, "H.
	Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-20 at 14:14 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in
> arch/powerpc/kernel/smp.c between commit 23d72bfd8f9f ("powerpc:
> Consolidate ipi message mux and demux") from the powerpc tree and commit
> 184748cc50b2 ("sched: Provide scheduler_ipi() callback in response to
> smp_send_reschedule()") from the tip tree.
> 
> The former superceded part of the latter's changes, so I just used the
> former for that.

I've done the merge and resolved the conflict properly (it's actually
non trivial due to some other changes) in the powerpc tree, I'll send a
pull request to Linus later today.

Cheers,
Ben.
