Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 571D2B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 02:42:56 +1000 (EST)
Date: Wed, 20 Jul 2011 18:42:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
Message-ID: <20110720164202.GA24244@elte.hu>
References: <20110715104547.29c3c509@kryten> <1311024956.2309.22.camel@laptop>
	<20110719144451.79bc69ab@kryten> <1311070894.13765.180.camel@twins>
	<20110720201436.19e9689a@kryten> <1311158708.5345.12.camel@twins>
	<20110720221420.153b0830@kryten>
	<CA+55aFxzaaMj8OUaust90c_hYKzg8NpRfmX4SzJ9SMwXzg5ocA@mail.gmail.com>
	<1311173910.5345.94.camel@twins>
	<CA+55aFxpH9-4rkH6CRXbjFCQMGNYGRMKgdgHUEthefQPumFKVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFxpH9-4rkH6CRXbjFCQMGNYGRMKgdgHUEthefQPumFKVg@mail.gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, mahesh@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jul 20, 2011 at 7:58 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> >
> > Right, so we can either merge my scary patches now and have 3.0 
> > boot on 16+ node machines (and risk breaking something), or delay 
> > them until 3.0.1 and have 16+ node machines suffer a little.
> 
> So how much impact does your scary patch have on machines that 
> don't have multiple nodes? If it's a "the code isn't even called by 
> normal machines" kind of setup, I don't think I care a lot.

NUMA systems will trigger the new code - not just 'weird NUMA 
systems' - but i still think we could try the patches, the code looks 
straightforward and i booted them on NUMA systems and it all seems 
fine so far.

Anyway, i'll push the new sched/urgent branch out in a few minutes 
and then you'll see the full patches in the commit notifications.

Thanks,

	Ingo
