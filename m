Return-Path: <phileas-fogg@mail.ru>
Received: from smtp51.i.mail.ru (smtp51.i.mail.ru [94.100.177.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 838D62C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 01:23:58 +1100 (EST)
Message-ID: <5132198C.8050300@mail.ru>
Date: Sat, 02 Mar 2013 16:23:56 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aaro Koskinen wrote:
> Hi,
>
> On Sat, Mar 02, 2013 at 03:40:19PM +0100, Phileas Fogg wrote:
>> Have anyone tested Linux 3 kernels on PowerMac G5 recently ?
>
> 3.8 boots normally to shell and is stable on G5 iMac (PowerMac8,1).
>
> A.
>

Thanks. Then i configured something wrongly probably.
I tried Linux 2.6.39.4 and it boots too.
I looked around on the Internet and it seems i'm not the only one
who has problems with Linux 3.x on my PowerMac G5.

The guy here has the same problem:
http://forums.gentoo.org/viewtopic-p-7222918.html


My PowerMac CPU
--------------------

cat /proc/cpuinfo
processor	: 0
cpu		: PPC970MP, altivec supported
clock		: 2000.000000MHz
revision	: 1.0 (pvr 0044 0100)

processor	: 1
cpu		: PPC970MP, altivec supported
clock		: 2000.000000MHz
revision	: 1.0 (pvr 0044 0100)

timebase	: 33333333
platform	: PowerMac
model		: PowerMac11,2
machine		: PowerMac11,2
motherboard	: PowerMac11,2 MacRISC4 Power Macintosh
detected as	: 337 (PowerMac G5 Dual Core)
pmac flags	: 00000000
L2 cache	: 1024K unified
pmac-generation	: NewWorld
