Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2FCF679F2
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Jun 2005 21:40:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
In-Reply-To: <20050606093411.GB3478@halley.zuhause>
References: <1117424155.5228.28.camel@gaston>
	<3db27390050530145939d260e4@mail.gmail.com>
	<20050602130502.GA6151@halley.zuhause>
	<1117750504.31082.76.camel@gaston>
	<20050603093316.GA4777@halley.zuhause>
	<1117838638.31082.173.camel@gaston>
	<20050606093411.GB3478@halley.zuhause>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 21:38:18 +1000
Message-Id: <1118057899.31082.293.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This looks to me as if it fails to switch to a tty which was not
> allocated before.

There is a known issue with "creating" a new tty vs. X that I though was
fixed, but may be still lurking around with nvidia stuff, I'll be
looking at it. Thanks.

Ben.
