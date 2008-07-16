Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id B9C94DE530
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 07:52:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Wed, 16 Jul 2008 16:53:13 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B3499C@ismail.innsys.innovsys.com>
In-Reply-To: <200807162345.26395.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807152150.35811.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B3490E@ismail.innsys.innovsys.com>
	<200807162345.26395.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Ok, I think this could be related mostly to two changes:
>=20
> * In 2.6.23, the process scheduler was replaced, the new one
> is the CFS,
> the 'completely fair scheduler'. This has changed a lot of data.
> To verify this, you could check out a git version just before and
> just after CFS went in.=20

I'll check. Checking the context switch is fairly fast, so this is a
goot time to learn bisect...

> * Obviously, the 6 percent change between ppc and powerpc should not
> be there. You can still try to use 'readprofile', or oprofile in
> timer based mode (i.e. without HW performance counters) to get some
> more data about where the time is spent on an identical
> kernel version.

I did run oprofile, but I could not figure out how to get it to show me
where in the kernel it was spending time. It showed that a lot of time
was spent in vmlinux, but not anything specific. I probably just don't
know how to set up or run oprofile correctly.
