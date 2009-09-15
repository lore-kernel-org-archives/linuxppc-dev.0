Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFE98B7BB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 07:51:59 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28776DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 07:51:58 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0909150943580.4950@localhost.localdomain>
References: <1252653473.8566.98.camel@pasglop>
	<1252999835.8375.205.camel@pasglop>
	<alpine.LFD.2.01.0909150943580.4950@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 07:51:28 +1000
Message-Id: <1253051488.8375.233.camel@pasglop>
Mime-Version: 1.0
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	FUJITA Tomonori <tomof@acm.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-15 at 09:53 -0700, Linus Torvalds wrote:
> It got a conflict with the AGP merge, but I fixed it up in what _seemed_ 
> to be the obvious manner. But somebody should check out the resulting
> drivers/char/agp/uninorth-agp.c file.

Thanks. 

Michel, can you dbl check it ?

Cheers,
Ben.
