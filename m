Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EB573DDDEA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 17:55:13 +1000 (EST)
Date: Sat, 03 May 2008 00:55:10 -0700 (PDT)
Message-Id: <20080503.005510.88048425.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
From: David Miller <davem@davemloft.net>
In-Reply-To: <1209801017.26383.21.camel@pasglop>
References: <1209770875.26383.14.camel@pasglop>
	<20080502.163855.96423898.davem@davemloft.net>
	<1209801017.26383.21.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 03 May 2008 17:50:17 +1000

> Best would be if we could get those runtime bits linked in the module
> itself, but I don't know enough about our toolchain to know if that's
> easy (I suppose everything is always possible :-)

The only downside is that you'd have N copies of these
routines, one for every module that emmited the libcalls.
