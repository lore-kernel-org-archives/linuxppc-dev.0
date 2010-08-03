Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73E3E1007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 15:43:56 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1OgAI3-000328-Bo
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Aug 2010 07:43:51 +0200
Date: Tue, 3 Aug 2010 07:43:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull my perf.git master branch
Message-ID: <20100803054337.GA1130@elte.hu>
References: <20100803010412.GA28995@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100803010412.GA28995@brick.ozlabs.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Scott Wood <scottwood@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> Ingo,
> 
> Please do a pull from my perf.git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git master
> 
> to get two commits.  They only affect the driver for the PMU on the
> Freescale embedded PowerPC processors.  One is from Peter Z. and has
> been around for some time.  The other fixes a bug introduced by a
> patch from Peter Z. that I sent upstream recently.
> 
> Thanks,
> Paul.
> 
> Peter Zijlstra (1):
>       perf, powerpc: Convert the FSL driver to use local64_t
> 
> Scott Wood (1):
>       perf, powerpc: fsl_emb: Restore setting perf_sample_data.period
> 
>  arch/powerpc/kernel/perf_event_fsl_emb.c |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)

Pulled, thanks a lot Paul!

	Ingo
