Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1C82DDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 18:29:00 +1000 (EST)
Date: Sat, 26 Jul 2008 01:26:01 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH] of_gpio: implement of_get_gpio_flags()
In-Reply-To: <20080725164815.GA23228@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0807260122100.26456@t2.domain.actdsltmp>
References: <fa686aa40807171105m22dda41dqb334dd5f7b2634d8@mail.gmail.com>
	<Pine.LNX.4.64.0807171302190.27902@t2.domain.actdsltmp>
	<20080717234201.GA15745@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807171807420.29856@t2.domain.actdsltmp>
	<20080718100549.GA28741@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807191352040.27586@t2.domain.actdsltmp>
	<20080721175357.GA1773@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807211340460.26456@t2.domain.actdsltmp>
	<20080723145650.GA13792@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807231551230.26456@t2.domain.actdsltmp>
	<20080725164815.GA23228@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jul 2008, Anton Vorontsov wrote:
>
> The name seems a bit unfortunate though, because one could read the
> function as it gets gpio flags only (though, we might implement
> this instead, but this way average driver will end up with parsing
> gpios = <> twice).

It is kind of a confusing name.  I'd be tempted to just change of_get_gpio,
it's a new function and it's only called from four places so it's not that
hard to change.
