Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 285A5DDE19
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 05:04:39 +1100 (EST)
Date: Thu, 30 Oct 2008 21:04:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [v5] powerpc: gpio driver for mpc8349/8572/8610 and compatible
Message-ID: <20081030180436.GA4975@oksana.dev.rtsoft.ru>
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
	<Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 06:07:47PM -0700, Trent Piepho wrote:
[...]
> But, I'm using the GPIOs to bit-bang a JTAG bus in the 20-30 MHz range.  The
> obvious GPIO driver is *much* too slow for that.  I got less than 3 MHz, and
> your driver looks like it might be slightly slower than my initial driver.

You can implement rapid (inlined) SOC-specific versions of
gpio_{get,set}_value() functions. And they can co-exist with the
gpiolib. It is quite easy to do.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
