Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 648C867DE8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 01:25:07 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061012095649.23bb6b35@localhost.localdomain>
References: <1160641793.4792.133.camel@localhost.localdomain>
	<20061012085617.3a5d6a31@localhost.localdomain>
	<1160664449.4792.147.camel@localhost.localdomain>
	<20061012095649.23bb6b35@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 01:24:58 +1000
Message-Id: <1160666698.4792.154.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It will also be easier to graft in a branch forward instead of a large
> amount of nops for large feature sections. I guess it will take some
> benchmarking to see what the breakeven point is.

Yeah, I've been thinking about that one for some time (in fact since I
did the first implementation of feature fixup). Thing is, back when it
was all asm, it was hard, and we never really had big feature sections.
Now that we have all that stuff with with PURR etc... in the exception
entry/return path, it might be worth having another look. I suspect that
the breakeven point will be very CPU dependant tho.

Ben.
