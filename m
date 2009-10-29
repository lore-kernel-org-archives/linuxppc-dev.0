Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21E62B7BEE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 17:57:13 +1100 (EST)
Date: Thu, 29 Oct 2009 07:55:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [GIT PULL] perf_event/tracing/powerpc patches from Anton Blanchard
Message-ID: <20091029065501.GB12874@elte.hu>
References: <19176.59441.523075.445864@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19176.59441.523075.445864@drongo.ozlabs.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> Here is a series of patches from Anton Blanchard that implement some 
> nice tracing and perf_event features on powerpc.  One of them is 
> generic perf_event stuff (adding software events for alignment faults 
> and instruction emulation faults).
> 
> Since this touches the perf_event and tracing subsystems as well as 
> the powerpc architecture code, I think the best way forward is for 
> both Ingo and Ben to pull it into their trees.  I have based it on the 
> most recent point in Linus' tree that Ingo had pulled into his perf 
> branches (as of yesterday or so).

The generic perf bits look good to me - can pull it if Ben OKs the 
PowerPC bits.

Thanks,

	Ingo
