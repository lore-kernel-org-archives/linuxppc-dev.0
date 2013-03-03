Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 54FE12C0308
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 06:24:33 +1100 (EST)
Message-ID: <1362338657.2969.20.camel@pasglop>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Mon, 04 Mar 2013 06:24:17 +1100
In-Reply-To: <5133A180.2040908@mail.ru>
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Denis Kirjanov <kirjanov@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-03-03 at 20:16 +0100, Phileas Fogg wrote:
> Benjamin Herrenschmidt wrote:
> > Thanks. It looks like a bisection might indeed be the way to go...
> >
> > Out of curiosity, have you tried without some of your additional drivers ?
> > Maybe one of them is the culprit...
> >
> > Cheers,
> > Ben.
> >
> 
> Not yet, will do.
> But I tested the official Debian Wheezy RC netinstall CD with Linux 3.2,
> it has the same problem and hangs at boot on my machine.

Ok, so it's definitely something about your configuration. Maybe
something in the 11,2 support code chokes on single-chip configs, I
don't have one of them to test, both mines are dual chip (ie. quad
core).

But it does look like a regression that should be bisectable, so let me
know went you're done there and what you get.

Cheers,
Ben.
