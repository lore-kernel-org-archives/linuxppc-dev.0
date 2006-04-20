Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id EFC77679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 18:17:50 +1000 (EST)
Message-ID: <1145528816.444761f0a9962@webmail.televes.com:443>
Date: Thu, 20 Apr 2006 12:26:56 +0200
From: Bastos Fernandez Alexandre <alebas@televes.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: RE: Watchdog on MPC82xx
References: <DCEAAC0833DD314AB0B58112AD99B93B85964A@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85964A@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune,

> On our 8265/8280 board, the max timeout of the watchdog timer was ~1.3
> seconds, so it kept resetting before the heartbeat function got called
> on boot.
>
> I had to add a watchdog reset to time_init() because it woud pause there
> for about 2 secondfs trying to see if there was a realtime clock.
>

I think that you are OK. Using the while(1) test suggested by Paul Bilke,
I could verify that time_init() is the cause for the reset. In fact, I have
no RTC on my board (so I suppose the delay looking for it will be maximum).

Thanks

Alex Bastos
