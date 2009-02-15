Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D962DDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 00:41:21 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LYhFB-00010Z-B4
	for linuxppc-dev@ozlabs.org; Sun, 15 Feb 2009 05:41:14 -0800
Message-ID: <22022709.post@talk.nabble.com>
Date: Sun, 15 Feb 2009 05:41:13 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: The state of Serial Rapid IO on MPC8548
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


Hi
 
I've noticed that in 2.6.29-rc5 Serial Rapid IO is only available
for 86xx processors. There's also no Freescale BSP for 8548.
What is the best source of SRIO driver for this CPU ? Can I
simply enable SRIO support in mainline kernel for 85xx and hope
it will work ?

Thanks.

Felix.
-- 
View this message in context: http://www.nabble.com/The-state-of-Serial-Rapid-IO-on-MPC8548-tp22022709p22022709.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
