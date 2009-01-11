Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E4F55474C9
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 12:20:07 +1100 (EST)
Date: Sun, 11 Jan 2009 02:20:06 +0100 (CET)
From: Guennadi Liakhovetski <lg@denx.de>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [GIT PULL] LED updates for 2.6.29
In-Reply-To: <1231633983.5330.32.camel@dax.rpnet.com>
Message-ID: <Pine.LNX.4.64.0901110216030.24501@axis700.grange>
References: <1231500186.5317.9.camel@dax.rpnet.com>
	<Pine.LNX.4.64.0901091231310.22972@t2.domain.actdsltmp>
	<1231543199.5317.63.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901100428230.1626@shell2.speakeasy.net>
	<1231633983.5330.32.camel@dax.rpnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <xyzzy@speakeasy.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 11 Jan 2009, Richard Purdie wrote:

> Ok, these are now queued in the LED tree:
> 
> http://git.o-hand.com/cgit.cgi/linux-rpurdie-leds/log/
> 
> I did merge the last three patches in one and make some changes to deal
> with some other outstanding issues. Let me know ASAP if there are any
> problems.

As already replied off-list, looks good mostly to me. Just have to keep in 
mind, that this version relies on drivers initialising their struct 
led_classdev instances to 0. Maybe it would be better to set the new 
max_brightness to 0 (or to LED_FULL) explicitly for them, as I was doing 
in my v2 of the patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.

DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
