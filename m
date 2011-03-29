Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CF9DB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 08:13:12 +1100 (EST)
Subject: Re: [PATCH] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric B Munson <emunson@mgebm.net>
In-Reply-To: <20110329142519.GA3527@mgebm.net>
References: <1301059689-4556-1-git-send-email-emunson@mgebm.net>
	<1301378637.2402.671.camel@pasglop> <20110329142519.GA3527@mgebm.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Mar 2011 08:12:45 +1100
Message-ID: <1301433165.2402.689.camel@pasglop>
Mime-Version: 1.0
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-03-29 at 10:25 -0400, Eric B Munson wrote:
> Here I made the assumption that the hardware would never remove more events in
> a speculative roll back than it had added.  This is not a situation I
> encoutered in my limited testing, so I didn't think underflow was possible.  I
> will send out a V2 using the signed 32 bit delta and remeber to CC stable
> this time. 

I'm not thinking about underflow but rollover... or that isn't possible
with those counters ? IE. They don't wrap back to 0 after hitting
ffffffff ?

Cheers,
Ben.
