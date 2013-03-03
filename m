Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 434952C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 16:31:22 +1100 (EST)
Message-ID: <1362288663.2969.15.camel@pasglop>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sun, 03 Mar 2013 16:31:03 +1100
In-Reply-To: <m2txotzs8y.fsf@igel.home>
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Phileas Fogg <phileas-fogg@mail.ru>,
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

On Sat, 2013-03-02 at 17:22 +0100, Andreas Schwab wrote:
> > Thanks. Then i configured something wrongly probably.
> > I tried Linux 2.6.39.4 and it boots too.
> > I looked around on the Internet and it seems i'm not the only one
> > who has problems with Linux 3.x on my PowerMac G5.
> 
> I have no problem with 3.8 either, but mine is a PowerMac7,3.

Ok. I have a quad core G5 which is also a 11,2, it's even my primary
workstation in the office :-) So it tends to work fine but I admit I
haven't updated the kernel on it in a while.

Phileas, send me the .config you're using, there might be an issue
there, I'll do some tests next week.

Cheers,
Ben.
