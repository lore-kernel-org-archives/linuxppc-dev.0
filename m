Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0D5C3DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 17:21:42 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LyhdK-0003ez-J4
	for linuxppc-dev@ozlabs.org; Tue, 28 Apr 2009 00:21:38 -0700
Message-ID: <23271549.post@talk.nabble.com>
Date: Tue, 28 Apr 2009 00:21:38 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: read data from FIFO memories to SDRAM with DMA on MPC8247
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


hi all:
now there was one question like this following:
there are two chips which are dual-port FIFO memories on my target board.
I attempt two read data with the way of DMA from FIFO to SDRAM
In my point, i need a driver of DMA and a driver of FIFO
but i have no idea at all that what should i do about this.

anyone can give some suggestions to me?
i.e. what i can do at frist? or what i can do in addition to the thing what
i said.

thanks
Sauce
-- 
View this message in context: http://www.nabble.com/read-data-from-FIFO-memories-to-SDRAM-with-DMA-on-MPC8247-tp23271549p23271549.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
