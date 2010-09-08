Return-Path: <tmarri@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id 2A1EEB70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 03:27:32 +1000 (EST)
Received: by mail-qy0-f171.google.com with SMTP id 30so5182304qyk.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Sep 2010 10:27:29 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1283464653-18492-1-git-send-email-tmarri@apm.com>
	<20100903020851.GC29732@hansolo.jdub.homelinux.org>
	<197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
	<20100905222340.GC2150@lixom.net>
	<01bb9090932e6984c887273078fd586f@mail.gmail.com>
	<20100906154526.GA515@lixom.net>
In-Reply-To: <20100906154526.GA515@lixom.net>
MIME-Version: 1.0
Date: Wed, 8 Sep 2010 10:27:25 -0700
Message-ID: <32d3989ca61a0bbfdfb691b1e578976b@mail.gmail.com>
Subject: RE: [PATCH] APM821xx: Add support for new SoC APM821xx
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > CPU portion uses SoC name.
>
> Hm, you're right. Confusing.
>
> Still, the cpu setup functions would make more sense to have the core
> name in, not the SoC name. Especially since multiple SoC families might
> use the same core, etc.
[Marri] I agree. Probably we need another node which identifies SoC as
well.


> > Different features from other.
>
> Actually, it doesn't. Linus has had a strong pushback to the ARM
> community
> because of this mentality. arch/powerpc already has 100 defconfigs.
>
> The use of devicetrees means that only the actual devices on your
> board,
> will be configured, so it doesn't do any damage to compile in more
> drivers
> than you happen to have. Thus generating a defconfig that is a superset
> of some of your more common boards, or for example one per family of
> boards.
>
> One of the arguments for having custom defconfigs per board is that
> customers that
> base designs off of your eval board needs them. But they will make
> other changes
> to the config to add drivers for whatever additional devices they have
> anyway.
[Marri] I see. I am working on the modifications.
Thanks
-marri
