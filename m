Return-Path: <vapier.adi@gmail.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 238C8B7C33
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 08:52:42 +1100 (EST)
Received: by ywh11 with SMTP id 11so691553ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 13:52:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263937351.18117.69.camel@Joe-Laptop.home>
References: <20100119211759.GE3804@infomag.iguana.be>
	<1263937351.18117.69.camel@Joe-Laptop.home>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 19 Jan 2010 16:52:21 -0500
Message-ID: <8bd0f97a1001191352n4968bebep2342912c571595fa@mail.gmail.com>
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, uclinux-dist-devel@blackfin.uclinux.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2010 at 16:42, Joe Perches wrote:
> On Tue, 2010-01-19 at 22:17 +0100, Wim Van Sebroeck wrote:
>> -static struct watchdog_info at32_wdt_info =3D {
>> +static const struct watchdog_info at32_wdt_info =3D {
>
> It'd be good to use a consistent structure name:
>
> static const struct watchdog_info ident =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0etc...
> }

i'd agree (obviously i'm partial to the "xxx_wdt_info" form), but i'd
worry about this after the watchdog implementations are finally
unified ... might be less code needing standardization at that point
-mike
