Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 43620DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 22:15:02 +1100 (EST)
Date: Thu, 30 Oct 2008 14:15:00 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 1/4] of_gpio: Return GPIO flags from of_get_gpio()A
Message-ID: <20081030111500.GB22008@oksana.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-1-git-send-email-tpiepho@freescale.com>
	<20081028143933.GA18453@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.64.0810291857110.25957@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <Pine.LNX.4.64.0810291857110.25957@t2.domain.actdsltmp>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 07:21:24PM -0700, Trent Piepho wrote:
[...]
> > Can you repost a fixed version with my Ack and Cc: Andrew Morton,
> > Benjamin Herrenschmidt?
> >
> > I think this change should go into the 2.6.28, so that we can
> > write new code on top of new API. Otherwise this change will cause
> > issues in the next merge window.
> 
> If you can get your patch into Ben's -next tree before the high .28-RCs come
> out,

I can't, that's the point. Big USB patches don't go through the
powerpc tree. ;-)

> I can just rebase my patch to that tree and make the changes to any new
> callers of of_get_gpio() that are there.

Never mind, just make sure your patch goes into the powerpc-next
early, thus we could start using the new API.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
