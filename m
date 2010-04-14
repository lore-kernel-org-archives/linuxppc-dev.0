Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CB31B7D13
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 16:54:35 +1000 (EST)
Subject: Re: [PATCH] powerpc/perf_event: Fix oops due to
	perf_event_do_pending call
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20100414064603.GA4714@drongo>
References: <20100414064603.GA4714@drongo>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Apr 2010 16:53:16 +1000
Message-ID: <1271227996.13059.138.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 16:46 +1000, Paul Mackerras wrote:
> Ben, please put this in your tree of fixes to go to Linus for 2.6.34,
> since it fixes a potential panic.

Should it go to -stable as well ? How far back ?

Cheers,
Ben.
