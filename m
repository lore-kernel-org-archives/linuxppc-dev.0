Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 017022C0303
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 06:04:16 +1100 (EST)
Message-ID: <1362337429.2969.17.camel@pasglop>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Mon, 04 Mar 2013 06:03:49 +1100
In-Reply-To: <51333F1C.4080605@mail.ru>
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
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

On Sun, 2013-03-03 at 05:16 -0700, Phileas Fogg wrote:
> i'm testing currently with slightly modified g5_defconfig. I enabled
> the Ralink driver for my USB WLAN NIC and some other stuff, nothing 
> fancy. Anyways, i'm sending you config for 3.0.67. Linux 3.0.67 hangs on 
> my machine too.
> 
> I cloned your GIT powerpc repository and at the moment bisecting and
> trying to find the commit which causes trouble on my machine.
> 
> I have already found out that
> the commit 27d934b28752b860cba6c0d77ea4598861d80998 is OK
> but
> the commit 0bd41dfc9fbbcf174d5336c1c9fc5ba917519761 is NOT.
> The problem appeared between Linux 2.6.39 and Linux-3.0-rc1.
> 
> Just my typical luck with PowerPC :) First PS3 and now G5.
> 
> I will report back as soon as i find the commit which causes the hangs.

Thanks. It looks like a bisection might indeed be the way to go... 

Out of curiosity, have you tried without some of your additional drivers ?
Maybe one of them is the culprit...

Cheers,
Ben.
