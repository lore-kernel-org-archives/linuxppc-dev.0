Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 2514FB7B63
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 09:04:48 +1100 (EST)
Received: by ywh37 with SMTP id 37so3638740ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 14:04:46 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <283847.1258305453891.JavaMail.ngmail@webmail10.arcor-online.net>
References: <283847.1258305453891.JavaMail.ngmail@webmail10.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 15:04:26 -0700
Message-ID: <fa686aa40911201404l5fb0ce13rfebd0bf7124ee8b2@mail.gmail.com>
Subject: Re: [Q/RFC] mpc52xx gpt api
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 15, 2009 at 10:17 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Hi all,
>
> I tried to use a '5200B internal timer for a very simple task - as pwm to=
 make a led blink, but apparently the current gpt implementation from Grant=
's tree does only support internal (cpu timer) modes which do not use the t=
imer io pin.
>
> The first hurdle was to actually get the timer itself - mpc52xx_gpt_from_=
irq() never returned something when I passed the timers (v)irq to it. =A0Wh=
at is the intended use of this function? =A0BTW, I do not need timer irq's,=
 so I believe there should be an other way to grab a timer!

There is a discussion running right now on the linux-embedded list
about implementing an PWM api.  It's worth hopping over and taking a
look.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
