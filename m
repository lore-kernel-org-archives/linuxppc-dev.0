Return-Path: <anton@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0DF45B7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 11:54:17 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00BE0DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 11:54:17 +1000 (EST)
Date: Mon, 27 Jul 2009 11:51:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/perf_counter: Add alignment-faults and
	emulation-faults sw events
Message-ID: <20090727015134.GA18301@kryten>
References: <20090706121845.GD4391@kryten> <1248659272.28464.29.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248659272.28464.29.camel@pasglop>
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


Hi Ben,

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

I've got another round of this series that I'll send out today.

Anton
