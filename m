Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E818867B45
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2005 08:45:06 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
In-Reply-To: <20050603093316.GA4777@halley.zuhause>
References: <1117424155.5228.28.camel@gaston>
	<3db27390050530145939d260e4@mail.gmail.com>
	<20050602130502.GA6151@halley.zuhause>
	<1117750504.31082.76.camel@gaston>
	<20050603093316.GA4777@halley.zuhause>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 08:43:57 +1000
Message-Id: <1117838638.31082.173.camel@gaston>
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


> Normally I use rivafb, but I tried video=ofonly and did not get a
> freeze. I tried it three times and I hope that this is good statistics.
> With 2.6.12-rc2 and riva fb I got the freeze in about 80% of all initial
> suspends, with rc{4,5-git6} and riva fb I had it everytime. But it may
> still well be that there is a random component since I learned to
> workaround the problem by switching to tty1 and thus don't trigger the
> freeze condition that often.

Ok, what happens if you run rivafb, ssh into the box, and open a new tty
(that is leave the box on X, but do something like echo "toto"
>/dev/tty8) to create a new tty in the background.

Does that trigger the freeze ?

Ben.
