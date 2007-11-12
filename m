Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16F5BDDE18
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 19:52:57 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Silence an annoying boot message
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071112051532.GA28394@lixom.net>
References: <20071112135339.9a01b115.sfr@canb.auug.org.au>
	<20071112051532.GA28394@lixom.net>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 19:52:36 +1100
Message-Id: <1194857556.18185.33.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Please use pr_debug() instead.
> 
> Feel free to change the only other DBG() user in the file as well,
> and take out the define of it

And for those who wonder where those DBG() come from, it's mostly me,
from a time when either pr_debug wasn't around, or because I wanted to
hook it to udbg_printf or other low level facilities before we had early
debug console.

There is no good reason to keep those around nowadays except bad
habit :-)

Cheers,
Ben
