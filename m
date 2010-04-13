Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE563B8015
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 22:29:47 +1000 (EST)
Subject: Re: [PATCH 2/5] sched: add asymmetric packing option for sibling
	domain
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20100409062118.DDF38CBB6E@localhost.localdomain>
References: <20100409062118.DDF38CBB6E@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 14:29:27 +0200
Message-ID: <1271161767.4807.1281.camel@twins>
Mime-Version: 1.0
Cc: Suresh Siddha <suresh.b.siddha@intel.com>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-04-09 at 16:21 +1000, Michael Neuling wrote:
> Peter: Since this is based mainly off your initial patch, it should
> have your signed-off-by too, but I didn't want to add without your
> permission.  Can I add it?

Of course! :-)

This thing does need a better changelog though, and maybe a larger
comment with check_asym_packing(), explaining why and what we're doing
and what we're assuming (that lower cpu number also means lower thread
number).
