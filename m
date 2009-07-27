Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 39ED4B7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 14:57:36 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93CB2DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 14:57:35 +1000 (EST)
Subject: Re: [PATCH] powerpc/perf_counter: Add alignment-faults and
	emulation-faults sw events
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20090727015134.GA18301@kryten>
References: <20090706121845.GD4391@kryten>
	<1248659272.28464.29.camel@pasglop>  <20090727015134.GA18301@kryten>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 14:57:10 +1000
Message-Id: <1248670630.5706.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, paulus@samba.org,
	a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-07-27 at 11:51 +1000, Anton Blanchard wrote:
> Hi Ben,
> 
> > BTW. The patch relies on some perctr changes I don't have in my tree
> > (PERF_COUNT_SW_ALIGNMENT_FAULTS isn't defined for me)
> > 
> > Ingo, how do you want to handle that ? Should I wait til round 2 of the
> > merge window before putting Anton's patch in or can I merge some of your
> > stuff in powerpc-next as pre-reqs ? Or you can just take Anton's patch
> > with my:
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > And stick it in your own queue (though pls, give me a pointer to the git
> > tree in question so I can verify that I don't get new stuff that
> > conflicts before we get to the merge window).
> 
> I've got another round of this series that I'll send out today.

Ok. I've pushed some to my -test branch, please let me know ASAP if I
have to withdraw some before I move them into -next

Cheers,
Ben.
