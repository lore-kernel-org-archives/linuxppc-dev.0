Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5226DDF98
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 12:11:54 +1000 (EST)
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <15a6025d58d0f62ee10efab20dc98278@kernel.crashing.org>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
	<f885d6b1472525fb5bebdd96ae4c3157@kernel.crashing.org>
	<1178151690.17299.46.camel@localhost.localdomain>
	<15a6025d58d0f62ee10efab20dc98278@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 03 May 2007 12:11:47 +1000
Message-Id: <1178158307.17299.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Isn't it just a GPIO, like on older Macs?  Of course, we
> cannot bring a CPU back online after doing that so it's
> pretty useless I suppose.

We don't know for sure what the gpio does... wether it does a CPU soft
reset or tickles the SPU to make it do special things that cause us to
branch at 0x100. We do get the CPU back after that though. We use that
to bring them in after boot.

Ben.
