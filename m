Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40D5BB7BBF
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 18:25:29 +1100 (EST)
Date: Mon, 19 Oct 2009 09:25:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc perf_event: Add alignment-faults and
	emulation-faults software events
Message-ID: <20091019072517.GB17960@elte.hu>
References: <20091018110929.GK4808@kryten> <20091018111126.GL4808@kryten>
	<20091018111300.GM4808@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091018111300.GM4808@kryten>
Cc: paulus@samba.org, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> Hook up the alignment-faults and emulation-faults events for powerpc.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

nice.

The first patch is for perf events - it would be nice if we could do the 
two PowerPC changes via the perf events tree - that would speed up the 
upstream availability of this new feature. Ben, what do you think?

	Ingo
