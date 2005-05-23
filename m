Return-Path: <BillR@aaesys.com>
Received: from aae-exchange.aaesys.com (mail.aaesys.com [67.131.247.41])
	by ozlabs.org (Postfix) with ESMTP id 295DC679F1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2005 07:45:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 23 May 2005 14:33:33 -0700
Message-ID: <E76D631A87C2874E895D1639A1CEDB96021194@aae-exchange.aaesys.com>
From: "Bill Rogers" <BillR@aaesys.com>
To: <hub-linux-ppc@trantor.staff.proxad.net>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: kernel panic in slab.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am seeing the same error.  Did you determine the cause?  Thanks.

Bill


kernel panic in slab.c
Hubert Figuiere hub-linux-ppc at trantor.staff.proxad.net  =
<mailto:linuxppc-dev%40ozlabs.org?Subject=3Dkernel%20panic%20in%20slab.c&=
In-Reply-To=3D1064497450.702.12.camel%40gaston>
Fri Sep 26 00:14:24 EST 2003=20
*	Previous message: kernel panic in slab.c  <015712.html>
*	Next message: kernel panic in slab.c  <015714.html>
	*	Messages sorted by: [ date ] <date.html> [ thread ] <thread.html> [ =
subject ] <subject.html> [ author ] <author.html>=20

Hi,

On Thu, 2003-09-25 at 15:44, Benjamin Herrenschmidt wrote:

> Nice to see you using Linux again :)

I never stopped :-)

>
> What machine is this ?

Custom network hardware with a PrPMC750 Motorola board as MPU. We have a
few tiny patches for our custom devices, but nothing important here
IMHO.


> The bug shows that the poison checker found that a freed block got
> overriden. It didn't display more infos about the kind of pattern
> it found and/or a backtrace ? That would be helpful.

I might investigate.

> I've been trying to track down such kind of memory corruption for
> some time now, so if you have a good handle on it, I'm interested,
> as I suspect something wrong is going on in recent 2.4s

Fine, then I feel like investigating it since memory corruption are
probably the worst bugs. I don't have a good handle on the problem. I
often crash while running either "bird" or "swapper" (uptime don't
exceed 5 or 10 minutes). Even worse, sometime it crashes during boot up.
The only thing I'm sure is that it is fully reproducible as it plagged
me for quite sometime. I first thaught that hardware was at fault (like
defective MPU), but my co-workers don't have the problem, and in fact
disabled debugging.


Thanks

Hub
--
Hubert Figui=E8re - Freebox SA. - +33 1 73 50 2 563
AIM/Yahoo!: hfiguiere, ICQ: 307453487

** Sent via the linuxppc-dev mail list. See <http://lists.linuxppc.org/>
