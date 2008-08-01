Return-Path: <SSparks@aclaratech.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 8BE6EDDE0F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 03:38:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Compact flash on mpc8349eITX
Date: Fri, 1 Aug 2008 12:36:39 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A835560863421AE@mail.twacs.com>
In-Reply-To: <20080801165059.GA7047@polina.dev.rtsoft.ru>
References: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
	<20080801165059.GA7047@polina.dev.rtsoft.ru>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From: Anton Vorontsov
>Sent: Friday, August 01, 2008 11:51 AM
>
>Works like a charm here. I use quite outdated u-boot though. Which one
>you use? I could try it (if it is community u-boot).

I'm using the head, which I grabbed last week: U-Boot
1.3.4-rc1-00012-g1953d12
TIA for checking your itx with this version.

>
>As for the backtrace you posted recently, I remeber I've noticed the
>similar issue long ago on some mITX board. I believe the board had
>hw issues indeed (or CF card I tested with). The problem could be in
>the IRQ line itself (for some reason it always low), or it could be
>IDE cmd/data lines at fault, so that IDE can't receive status read
>command and does not deassert the interrupt line... quite hard to
>tell.

Thanks for confirming.. I was losing my mind :-)
This looks like it is indeed a HW problem with the ITX. Are you aware of
any threads/documents describing the issue? We based our custom HW off
the ITX schematic with regards to the CF, and I hope we didn't copy over
_that_ problem :-/

Cheers,
Sam
