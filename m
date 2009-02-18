Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5B46DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 13:22:58 +1100 (EST)
Subject: Re: Please pull from 'next' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0902171551460.23647@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0902171551460.23647@blarg.am.freescale.net>
Content-Type: text/plain
Date: Wed, 18 Feb 2009 13:22:52 +1100
Message-Id: <1234923772.14060.322.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'd also like the opcode patch to go in since several patches depend on
> that (doorbell, tlbilx).  If you want to ack the patch I can put it into
> my next branch for you.

It's already in my test branch, which for some reason I forgot to push
out... Doing some updates now, you'll get it.

Cheers,
Ben.
