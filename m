Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F7512C0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 07:22:39 +1100 (EST)
Message-ID: <1362687724.6977.1.camel@pasglop>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Fri, 08 Mar 2013 07:22:04 +1100
In-Reply-To: <5138F3AB.5040401@mail.ru>
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
 <1362338657.2969.20.camel@pasglop> <5138F3AB.5040401@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andreas Schwab <schwab@linux-m68k.org>, Denis Kirjanov <kirjanov@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-03-07 at 21:08 +0100, Phileas Fogg wrote:
> And the bisect couldn't find the commit which causes hangs on my
> machine.
> All commits which were provided by the bisect were bad.
> And the commit before tha last bad bisect commit was bad too.
> I did bisect several times, and got the same results.
> 
> Fo testing i used linux-3.0.y branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git.
> 
> Did i miss something or do something wrong here ?

Did git bisect go down a merge commit ? It does for me if I try that and
asks to test that merge first. If you get that wrong it can get very
confused.

That's all I can think of... do you have the bisection log just in
case ?

Also you can use gitk -- arch/powerpc to look at the changes to powerpc
code and try manually random points before/after that if you think
bisect isn't doing the right thing.

Cheers,
Ben.
