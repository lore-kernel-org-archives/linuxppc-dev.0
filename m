Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D504DDDD8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 07:56:34 +1100 (EST)
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090205134700.GB3000@yoda.jdub.homelinux.org>
References: <1233806493.4612.65.camel@pasglop>
	<20090205134700.GB3000@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Fri, 06 Feb 2009 07:56:22 +1100
Message-Id: <1233867382.4612.98.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Which begs the question of what master is for.  So far, it's just been
> a mirror of next from what I can tell.  Maybe it should just track
> Linus' tree?

I've been wondering myself what to do with it ... I may just leave it to
track linus indeed. Or maybe just delete it.

Ben.
