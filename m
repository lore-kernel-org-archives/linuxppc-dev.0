Return-Path: <phileas-fogg@mail.ru>
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [94.100.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 498AB2C02C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 06:32:28 +1100 (EST)
Message-ID: <513E3111.9010501@mail.ru>
Date: Mon, 11 Mar 2013 20:31:29 +0100
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
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
 <1362338657.2969.20.camel@pasglop> <5138F3AB.5040401@mail.ru>
 <1362687724.6977.1.camel@pasglop> <513BD33B.7020305@mail.ru>
 <1362876308.6977.42.camel@pasglop> <513C6641.2010308@mail.ru>
 <1362919948.4534.1.camel@pasglop>
In-Reply-To: <1362919948.4534.1.camel@pasglop>
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

On 03/10/2013 01:52 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2013-03-10 at 11:53 +0100, Phileas Fogg wrote:
>> Good news :) I found the bug.
>> MMU features were not set properly for PPC970MP DD1.0 which,
>> unfortunately, my machine has.
>> Damn, one line fix but one week searching.
>> Linux 3.8.2 boots without problems now :)
>
> Nice one ! I didn't think anybody shipped a DD1.0 chip ! :-)
>
> Looks like some typo/thinko in the cputable and you are one of the very
> rare victims of it. I'll fix that up. Regarding the IDE problem, can you
> shoot a note to Tejun who wrote that patch (and CC me) ? I do recommend
> switching to libata but we should still fix the problem with legacy IDE.
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

The IDE-CD bug appears to be already fixed. I tested g5_defconfig with 
Linux 3.8.2 and it boots OK. I think i saw a commit regarding this issue 
in git.

Regards
