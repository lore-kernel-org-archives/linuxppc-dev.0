Return-Path: <a.p.zijlstra@chello.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2527CB7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 16:23:50 +1000 (EST)
Received: from viefep20-int.chello.at (viefep20-int.chello.at [62.179.121.40])
	by ozlabs.org (Postfix) with ESMTP id CC593DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 16:23:47 +1000 (EST)
Subject: Re: [PATCH] powerpc/perf_counter: Add alignment-faults and
	emulation-faults sw events
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1248659272.28464.29.camel@pasglop>
References: <20090706121845.GD4391@kryten> <1248659272.28464.29.camel@pasglop>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 08:26:02 +0200
Message-Id: <1248675962.6987.1423.camel@twins>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, paulus@samba.org,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-07-27 at 11:47 +1000, Benjamin Herrenschmidt wrote:

> Sounds good.
> 
> BTW. The patch relies on some perctr changes I don't have in my tree
> (PERF_COUNT_SW_ALIGNMENT_FAULTS isn't defined for me)
> 
> Ingo, how do you want to handle that ? Should I wait til round 2 of the
> merge window before putting Anton's patch in or can I merge some of your
> stuff in powerpc-next as pre-reqs ? Or you can just take Anton's patch
> with my:
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> And stick it in your own queue (though pls, give me a pointer to the git
> tree in question so I can verify that I don't get new stuff that
> conflicts before we get to the merge window).

Please send all missing bits to me and I'll stuff it into:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/linux-2.6-perf.git perf-master
