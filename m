Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 41FD0DE296
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 03:59:44 +1000 (EST)
Date: Fri, 1 Aug 2008 21:59:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Sparks, Sam" <SSparks@aclaratech.com>
Subject: Re: Compact flash on mpc8349eITX
Message-ID: <20080801175941.GA21814@polina.dev.rtsoft.ru>
References: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
	<20080801165059.GA7047@polina.dev.rtsoft.ru>
	<6011A7C9CD0EE74792C3ED2A835560863421AE@mail.twacs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <6011A7C9CD0EE74792C3ED2A835560863421AE@mail.twacs.com>
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

On Fri, Aug 01, 2008 at 12:36:39PM -0500, Sparks, Sam wrote:
> >From: Anton Vorontsov
> >Sent: Friday, August 01, 2008 11:51 AM
> >
> >Works like a charm here. I use quite outdated u-boot though. Which one
> >you use? I could try it (if it is community u-boot).
> 
> I'm using the head, which I grabbed last week: U-Boot
> 1.3.4-rc1-00012-g1953d12
> TIA for checking your itx with this version.

U-Boot 1.3.4-rc1-00012-g1953d12 (Aug  1 2008 - 21:45:42) MPC83XX

The CF still works.

> >As for the backtrace you posted recently, I remeber I've noticed the
> >similar issue long ago on some mITX board. I believe the board had
> >hw issues indeed (or CF card I tested with). The problem could be in
> >the IRQ line itself (for some reason it always low), or it could be
> >IDE cmd/data lines at fault, so that IDE can't receive status read
> >command and does not deassert the interrupt line... quite hard to
> >tell.
> 
> Thanks for confirming.. I was losing my mind :-)
> This looks like it is indeed a HW problem with the ITX. Are you aware of
> any threads/documents describing the issue? We based our custom HW off
> the ITX schematic with regards to the CF, and I hope we didn't copy over
> _that_ problem :-/

I don't think it was a hw design problem, more likely somebody
fried the CF slot on that board (either by hot-plugging the CF, or via
inserting CF 5V only flash.. either of this is forbidden for the
8349mITX boards).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
