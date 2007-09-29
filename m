Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FAEFDDE1B
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 08:19:59 +1000 (EST)
Subject: Re: Powerbook shuts down hard when hot, patch found
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200709292353.06476.mb@bu3sch.de>
References: <200709282332.52819.mb@bu3sch.de>
	<200709291322.59607.mb@bu3sch.de> <1191102715.28637.0.camel@pasglop>
	<200709292353.06476.mb@bu3sch.de>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 08:19:53 +1000
Message-Id: <1191104393.28637.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> This all smells to me like a silicon bug, so I'd start searching
> in the silicon erratas. But I'm not sure, of course. It's also strange
> that it depends on temperature. (That's why I first expected the PMU
> would cause this).
> 
> Thanks for your help.

Could be that we are creating a short by driving the output low, thus
causing the silicon to heat up, but that's strange.

Also, the other change I made you do turns these into inputs, thus the
DDL lines should be pulled up, unless ... the board doesn't have
pullups.

Ben.
