Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87BC4DDE37
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 10:38:35 +1100 (EST)
Subject: Re: [PATCH] Update udbg_progress() to display the integer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17865.2853.132102.769702@cargo.ozlabs.ibm.com>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 10:38:22 +1100
Message-Id: <1170805102.2620.264.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It would have been for the 2-line display on IBM RS/6000 machines.  If
> that's still needed, we can put it in arch/powerpc/platforms/chrp
> somewhere, so feel free to remove it from ppc_init().

Do we actually care about this progress stuff ? I've been tempted more
than once to rip it all off... we have console access as early as we can
do progress output on most powerpc platforms nowadays.

If we really want some way of ack'ing that the kernel reached known
known steps with something different than a printk-type interface, then
we should probably have somewhere a list of well defined numeric
constants and use those, but then, I don't like magic numbers.

Ben.
