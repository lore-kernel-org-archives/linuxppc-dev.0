Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFF71DDF6B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:34:51 +1100 (EST)
Date: Tue, 9 Dec 2008 20:33:47 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 4/4] leds: Let GPIO LEDs keep their current state
In-Reply-To: <1228298664.9126.3.camel@ted>
Message-ID: <Pine.LNX.4.64.0812092013030.28806@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-4-git-send-email-tpiepho@freescale.com>
	<1226933427.17109.15.camel@ted>
	<Pine.LNX.4.64.0811201640570.11673@t2.domain.actdsltmp>
	<20081123123154.GB7310@ucw.cz> <1228298664.9126.3.camel@ted>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008, Richard Purdie wrote:
> On Sun, 2008-11-23 at 13:31 +0100, Pavel Machek wrote:
>> On Thu 2008-11-20 17:05:56, Trent Piepho wrote:
>>> I thought of that, but it ends up being more complex.  Instead of just
>>> using:
>>> static const struct gpio_led myled = {
>>>  	.name = "something",
>>>  	.keep_state = 1,
>>> }
>>>
>>> You'd do something like this:
>>>  	.default_state = LEDS_GPIO_DEFSTATE_KEEP,
>>>
>>> Is that better?
>>
>> Yes.
>
> Yes, agreed, much better.

Oh very well, I'll change it.  But I reserve the right to make a sarcastic
commit message.
