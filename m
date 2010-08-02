Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD767B6F0E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 03:22:04 +1000 (EST)
Subject: Re: [PATCH] perf, powerpc: Convert the FSL driver to use local64_t
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100802061851.GA898@brick.ozlabs.ibm.com>
Date: Mon, 2 Aug 2010 12:21:54 -0500
Message-Id: <64B97380-B92E-4B00-B36A-FDAC80643746@kernel.crashing.org>
References: <20100802061851.GA898@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 2, 2010, at 1:18 AM, Paul Mackerras wrote:

> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>=20
> For some reason the FSL driver got left out when we converted perf
> to use local64_t instead of atomic64_t.
>=20
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
> This is against the perf/core branch in the tip tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
> Posting here for comment.
>=20
> arch/powerpc/kernel/perf_event_fsl_emb.c |   28 =
++++++++++++++--------------
> 1 file changed, 14 insertions(+), 14 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k=
