Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8194ADDD0C
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2009 08:51:15 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MAts0-0002tS-St
	for linuxppc-dev@ozlabs.org; Sun, 31 May 2009 15:51:12 -0700
Message-ID: <23807779.post@talk.nabble.com>
Date: Sun, 31 May 2009 15:51:12 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: is the resolution of do_gettimeofday in usec?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,
i have board that contains MPC8555 processor with linux 2.6.27 ported to it.
i want to use an accurate function to measure the time. i searched the
kernel code & i found several functions but i read that the do_gettimeofday
is the most accurate one since it has a timer resolution of usec.

my question is how this function give this accuracy while the kernel timer
is 4msec?
is this a real accuracy or does it convert from msec to usec?
or does it depend on another timer counter that has this resolution?
or may b it measure the clock cycles of the processor within certain
interval?

Note that the freq of the processor is 850MHz.

Unfortunately, the function is implemented in assembly & i cant understand
it?
so can u tell me how this accurate numbers can be got or they r just fake
numbers?

thanks
-- 
View this message in context: http://www.nabble.com/is-the-resolution-of-do_gettimeofday-in-usec--tp23807779p23807779.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
