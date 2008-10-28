Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id B81DFDE108
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 01:53:13 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2557372rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 07:53:12 -0700 (PDT)
Message-ID: <fa686aa40810280753lc555683y5d32da678384438@mail.gmail.com>
Date: Tue, 28 Oct 2008 08:53:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/4] of_gpio: Return GPIO flags from of_get_gpio()
In-Reply-To: <20081028143933.GA18453@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-1-git-send-email-tpiepho@freescale.com>
	<20081028143933.GA18453@oksana.dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 8:39 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Can you repost a fixed version with my Ack and Cc: Andrew Morton,
> Benjamin Herrenschmidt?
>
> I think this change should go into the 2.6.28, so that we can
> write new code on top of new API. Otherwise this change will cause
> issues in the next merge window.

While I like this series, it should not be pushed for .28.  The window
is closed and we are in bug-fix-only mode.  Focus on getting it into
Ben's -next tree instead.  That will deal with any merge window
conflicts.  I'd be happy to pull it through my 5200 tree when you post
the next version.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
