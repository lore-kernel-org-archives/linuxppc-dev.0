Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B92E8DDF8E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:10:17 +1000 (EST)
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1178150936.17299.37.camel@localhost.localdomain>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
	<1178150936.17299.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 03 May 2007 10:10:11 +1000
Message-Id: <1178151011.17299.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Ah... hrm... so it's possible that Darwin goes NAP but flushes the cache
> before suspend-to-ram bcs the CPU is going down... let me check.
> 
> Nah, darwin uses HID0:sleep

Ahhh nooo .... there's a special code path for 64 bits CPUs and indeed,
it uses NAP.

Ben.
