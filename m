Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 005CADDE02
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 21:01:10 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080503.005510.88048425.davem@davemloft.net>
References: <1209770875.26383.14.camel@pasglop>
	<20080502.163855.96423898.davem@davemloft.net>
	<1209801017.26383.21.camel@pasglop>
	<20080503.005510.88048425.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 03 May 2008 21:01:02 +1000
Message-Id: <1209812462.26383.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-05-03 at 00:55 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Sat, 03 May 2008 17:50:17 +1000
> 
> > Best would be if we could get those runtime bits linked in the module
> > itself, but I don't know enough about our toolchain to know if that's
> > easy (I suppose everything is always possible :-)
> 
> The only downside is that you'd have N copies of these
> routines, one for every module that emmited the libcalls.

Yup, so it's mostly a matter of balance, choosing which of these should
be kept in the kernel and which of these linked directly I suppose,
possibly based on usage frequency and size. A pain in the neck tho...

Ben.
