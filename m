Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 08E7367E9E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2005 01:13:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 11 Aug 2005 10:13:23 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859421@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: CLOCK_TICK_RATE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I have found that I need to set CLOCK_TICK_RATE (currently defined in
include/asm-ppc/timex.h) to something else.
Right now it is set to the PC timer clock value (1193180Hz). I need to
set it to the frequency of my decrementer instead (busfreq/4)

Right now the value of theis define means the wall-clock time on ALL ppc
(and ppc64) systems that does not use the old I386 timer freqyuencly
(most all?) are using the wrong values.

How can I change this to be platform dependant?=20
The other problem is that it has to be hardcoded on compile time, but
I'm not going to worry to much about that.
