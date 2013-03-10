Return-Path: <phileas-fogg@mail.ru>
Received: from smtp35.i.mail.ru (smtp35.i.mail.ru [94.100.177.95])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 867322C0308
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 18:54:58 +1100 (EST)
Message-ID: <513C3C15.80301@mail.ru>
Date: Sun, 10 Mar 2013 08:53:57 +0100
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
 <1362876308.6977.42.camel@pasglop>
In-Reply-To: <1362876308.6977.42.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 03/10/2013 01:45 AM, Benjamin Herrenschmidt wrote:

>
> Have you verified that if you checkout git at the above commit point, it
> fails and if you then just revert that commit on top, it works again ?
>
> The above should have been mostly a NOP change but I'll have a closer
> look in case a typo of some kind actually broke something.
>

Verified, the commit 65f47f1339dfcffcd5837a307172fb41aa39e479 hangs too.
After reverting the changes of the commit 
44ae3ab3358e962039c36ad4ae461ae9fb29596c, it is booting fine again.

regards
