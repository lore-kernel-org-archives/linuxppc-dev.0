Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id E64D8DDF71
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 21:31:52 +1100 (EST)
Message-ID: <49799C8C.80903@denx.de>
Date: Fri, 23 Jan 2009 11:31:40 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH] mb862xx: Restrict compliation of platform driver to PPC
References: <496A89A1.8050302@gmail.com>	
	<646765f40901191650v5320f5e4tcc5fb7da0555ade1@mail.gmail.com>	
	<20090120011945.GA23380@oksana.dev.rtsoft.ru>
	<646765f40901191800y27530acaw74edc01abdd13e68@mail.gmail.com>
In-Reply-To: <646765f40901191800y27530acaw74edc01abdd13e68@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
	Matteo Fortini <m.fortini@selcomgroup.com>, linux-kernel@vger.kernel.org,
	Krzysztof Helt <krzysztof.h1@poczta.fm>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Julian Calaby wrote:
> On Tue, Jan 20, 2009 at 12:19, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
>> Should be Anatolij. ;-)
> 
> Who is the first person on the list, I guess he's missed this or isn't
> reading his email.

I missed this, sorry.

> Before we commit to fixing this properly, is it really worth it? Is
> this hardware ever likely to be used with SPARC?

I don't think it will ever be used with SPARC, so your patch is Ok.

> Given that there are PCI and OF versions of the driver, it seems to me
> that this is available as a PCI expansion card, and as a graphics chip
> built into some PPC motherboards. The initial commit says: "Lime GDC
> support is known to work on PPC440EPx based lwmon5 and MPC8544E based
> socrates embedded boards, both equipped with Lime GDC." so I'm
> guessing that this graphics chip is designed for embedded boards. I
> can find references to it's use in embedded automotive applications on
> Google but I can't find any reference to the Fujitsu LIME (MB86276)
> and SPARC on Google.

If LIME chip should ever be used with SPARC, support for this
could be added later. LIME doesn't have PCI interface, it is
connected to the host cpu bus. PCI version of the driver is for
CoralP and Carmine chips which have PCI interface.

Anatolij
