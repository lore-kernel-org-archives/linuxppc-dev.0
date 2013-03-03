Return-Path: <phileas-fogg@mail.ru>
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BD8262C030D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 06:19:13 +1100 (EST)
Message-ID: <5133A180.2040908@mail.ru>
Date: Sun, 03 Mar 2013 20:16:16 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop>
In-Reply-To: <1362337429.2969.17.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Benjamin Herrenschmidt wrote:
> Thanks. It looks like a bisection might indeed be the way to go...
>
> Out of curiosity, have you tried without some of your additional drivers ?
> Maybe one of them is the culprit...
>
> Cheers,
> Ben.
>

Not yet, will do.
But I tested the official Debian Wheezy RC netinstall CD with Linux 3.2,
it has the same problem and hangs at boot on my machine.

regards
