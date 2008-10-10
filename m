Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3458ADE37D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 00:59:06 +1100 (EST)
Message-ID: <48EF5FAC.1060807@billgatliff.com>
Date: Fri, 10 Oct 2008 08:59:08 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
	<Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
In-Reply-To: <Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: linux-embedded@vger.kernel.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> 
> Were did you actually sent them to?  Apparently you sent them to each mailing
> list (at least linux-embedded and linuxppc-dev) _separately_ (or using bcc).

I sent them separately to linux-embedded, linuxppc-dev, and linux-arm-kernel.
Those three groups seemed to have the developers who were most likely to provide
a motivated review and constructive response; unfortunately, some are
subscriber-only and so I couldn't just cross-post.  I was expecting some
criticism for this, but I'm not sure there's a good alternative.

I don't like the idea of posting in so many places, but PWM is a pretty
expansive topic: just about every SoC under the sun has some ability to do PWM,
and people use the signals for all sorts of things.  Both have to be taken into
consideration by the API, hence I need lots of review and feedback.

There isn't a lot of traffic on linux-embedded, and I'm not sure how many people
who read linux-arm-kernel also read linuxppc-dev.  Lkml's topic coverage is
huge, so I don't know how many hardcore embedded developers I would encounter
there.  I was hoping for a round of feedback at a lower level before pushing
anything upstream like that.

> Hence different people may give the same comments without knowing about each
> other, and you may have to explain everything multiple times.

Hasn't been a problem so far.  I posted the first version of the code on l-a-k,
and got some feedback on the pwm_device API and a lot of feedback on the way
users wanted to use the API to realize applications.  I incorporated all of it,
and in this "release" I broadened the exposure per recommendations received from
l-a-k.

> I would go for lkml and linux-embedded, _together_.

So, you're saying the same thing as me, basically.  But leaving out the lists
with very high ratios of device-specific domain knowledge, which is important
for the backend parts of what I'm proposing.  Blackfin's PWM-capable peripherals
work differently from those commonly found in ARM and PPC, for example.  I
haven't run anything by the MIPS or AVR guys, but I'm guessing they would have
something to add, too.

I'm beginning to appreciate what everyone must have had to deal with for GPIO.  :)


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
