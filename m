Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id C3B9DDDE22
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 23:00:26 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Loz7G-0001wd-Dj
	for linuxppc-dev@ozlabs.org; Wed, 01 Apr 2009 05:00:22 -0700
Message-ID: <22824979.post@talk.nabble.com>
Date: Wed, 1 Apr 2009 05:00:22 -0700 (PDT)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: /dev/random on PPC40EXr
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


Hi,

On my custom board based on 405EXr /dev/random produces no output
at all, and /dev/urandom is not random enough for our purposes. Saving
entropy pool between reboots doesn't help much.

What can be done to increase the entropy of the system ?
I was thinking of adding IRQF_SAMPLE_RANDOM to network driver,
but since not too many drivers implement it, I don't know whether
it's a good idea or not. 

Is there any work in progress to develop hw_random driver for 4xx
TRNG ?

Thanks a lot.

Felix.
-- 
View this message in context: http://www.nabble.com/-dev-random-on-PPC40EXr-tp22824979p22824979.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
