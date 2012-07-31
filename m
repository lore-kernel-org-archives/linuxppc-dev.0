Return-Path: <ronne@list.ru>
Received: from smtp20.mail.ru (smtp20.mail.ru [94.100.176.173])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 24E092C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 02:40:10 +1000 (EST)
Message-ID: <50180A64.8060400@list.ru>
Date: Tue, 31 Jul 2012 20:40:04 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Update g5_defconfig
References: <1343011712.2957.5.camel__22210.4697292254$1343011753$gmane$org@pasglop>
 <m2fw8jyn43.fsf@igel.home> <1343027168.2957.30.camel@pasglop>
In-Reply-To: <1343027168.2957.30.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

23.07.2012 11:06, Benjamin Herrenschmidt пишет:
> On Mon, 2012-07-23 at 09:04 +0200, Andreas Schwab wrote:
>> Benjamin Herrenschmidt<benh@kernel.crashing.org>  writes:
>>
>>> This updates the g5 defconfig to include nouveau instead of nvidiafb
>>> (which works much better nowadays, in fact the latter crashes on modern
>>> distros),
>> Does it?  Nvidiafb is super stable here, whereas nouveau has a lot of
>> problems.
> nvidiafb crashes solid here when X gets involved.
>
> What do you mean by "lots of problems" ? I've been using nouveau for a
> long time now on my two quad g5's including 3D, gnome-shell etc...
> without anything more than a glitch or two on the edge of windows...
>
> Also can you remind me what machine model and what video card variant ?
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
>
nouveau doesn't work on my machine. There is a bug in Xorg project
https://bugs.freedesktop.org/show_bug.cgi?id=21273 It need to make
a workaround for correct initialization of video card. Unfortunately,
I am not skilled enough for it.
Nvidiafb worked fine for me, but I am not using it.

Andrey
