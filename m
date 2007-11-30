Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E2ACCDDE47
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 22:41:10 +1100 (EST)
Date: Fri, 30 Nov 2007 14:45:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071130114541.GA11047@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
	<20071127212222.GB10829@lixom.net>
	<200711272233.00456.arnd@arndb.de>
	<20071128154904.GA20722@localhost.localdomain>
	<474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina>
	<474FE332.8080103@ru.mvista.com>
	<20071130105849.GA10840@localhost.localdomain>
	<474FEE5D.2030905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <474FEE5D.2030905@ru.mvista.com>
Cc: Olof Johansson <olof@lixom.net>, cbou@mail.ru, linux-ide@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 02:05:01PM +0300, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
> 
> >>>Remaining question: any preferred name for that property? pio-mode okay?
> >>>It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.
> 
> >>  I've already suggested "generic". A name "simple" also comes to my mind.
> 
> >You've misread my question. I didn't ask about driver name, but pio-mode
> >property.
> 
>    I'm OK with "pio-mode" then. Just don't think it makes much sense in the 
> context of this driver which has no provision for the programming the mode 
> timings (and if there were some provision, the *generic* platform driver 
> couldn't handle it anyway).

What sense it makes then?.. We're specifying bus limitations wrt
PIO modes.

Oh, I think you meant that bus can't be reconfigured by generic
driver, that's true. But I didn't mean this as a purpose for
pio-mode property (though it still could be used for that
purpose by other drivers).

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
