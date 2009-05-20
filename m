Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 50F99DE155
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 18:55:50 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M6haU-000378-7l
	for linuxppc-dev@ozlabs.org; Wed, 20 May 2009 01:55:46 -0700
Message-ID: <23631525.post@talk.nabble.com>
Date: Wed, 20 May 2009 01:55:46 -0700 (PDT)
From: konamo <dai.michael@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: AMCC 405ex memory size issue
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


Hi all,
  we are using u-boot 2009.01, linux-2.6.25-rc2, 1GB DDR2 memory(2Gbit * 4,
1 rank), AMCC powerpc 405ex, both 1G and 512MB memory works fine under
u-boot, but linux boot fails in 1G memory, if we limit mem=512M, linux could
boot. Could anyone pls help us how to find the root cause? thanks
-- 
View this message in context: http://www.nabble.com/AMCC-405ex-memory-size-issue-tp23631525p23631525.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
