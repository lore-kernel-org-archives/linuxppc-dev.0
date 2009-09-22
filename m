Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72516B7B6B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 18:01:06 +1000 (EST)
Subject: Re: [PATCH] perf_event, powerpc: Fix compilation after big
	perf_counter rename
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090922072834.GA25470@elte.hu>
References: <19128.4280.813369.589704@cargo.ozlabs.ibm.com>
	<1253584591.7103.197.camel@pasglop>  <20090922072834.GA25470@elte.hu>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 18:00:15 +1000
Message-Id: <1253606415.7103.216.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-22 at 09:28 +0200, Ingo Molnar wrote:
> 
> Nevertheless you are right that i should have caught this particular 
> PowerPC build bug - i missed it - sorry about that!
> 
Allright. Well, to help in general, we are setting up a build-bot
here too that will build -tip HEAD for at least powerpc daily with
a few configs too.

Cheers,
Ben.
