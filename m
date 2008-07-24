Return-Path: <jochen@scram.de>
Message-ID: <4888746B.8020003@scram.de>
Date: Thu, 24 Jul 2008 14:24:11 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: Getting GPIO to build again
References: <9e4733910807232009o634027cajde78395f95ae95ce@mail.gmail.com>	<9e4733910807232034x3af76073x979ef608ddfbebfb@mail.gmail.com>
	<20080724120839.GA24673@polina.dev.rtsoft.ru>
In-Reply-To: <20080724120839.GA24673@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> Though, with this patch:
> http://lkml.org/lkml/2008/7/10/269
> 
> We'll only have to select ARCH_WANT_OPTIONAL_GPIOLIB. Maybe for whole
> powerpc.

That would simplify the GPIO support patches for CPM1/2, as well.

Thanks,
Jochen
