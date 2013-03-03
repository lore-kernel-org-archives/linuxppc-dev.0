Return-Path: <kirjanov@gmail.com>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 083282C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 19:23:27 +1100 (EST)
Received: by mail-ee0-f54.google.com with SMTP id c41so3326626eek.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Mar 2013 00:23:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1362288663.2969.15.camel@pasglop>
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
Date: Sun, 3 Mar 2013 11:23:23 +0300
Message-ID: <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Denis Kirjanov <kirjanov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phileas Fogg <phileas-fogg@mail.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andreas Schwab <schwab@linux-m68k.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm running 3.7.6 without any problems on my quad core machine. You
have to try to compile with g5_defconfig...

On 3/3/13, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2013-03-02 at 17:22 +0100, Andreas Schwab wrote:
>> > Thanks. Then i configured something wrongly probably.
>> > I tried Linux 2.6.39.4 and it boots too.
>> > I looked around on the Internet and it seems i'm not the only one
>> > who has problems with Linux 3.x on my PowerMac G5.
>>
>> I have no problem with 3.8 either, but mine is a PowerMac7,3.
>
> Ok. I have a quad core G5 which is also a 11,2, it's even my primary
> workstation in the office :-) So it tends to work fine but I admit I
> haven't updated the kernel on it in a while.
>
> Phileas, send me the .config you're using, there might be an issue
> there, I'll do some tests next week.
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


-- 
Regards,
Denis
