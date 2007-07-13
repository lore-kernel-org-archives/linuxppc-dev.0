Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71C35DDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 06:32:40 +1000 (EST)
Message-ID: <4697E160.9000009@freescale.com>
Date: Fri, 13 Jul 2007 15:32:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Fix Tsi108 ethernet driver performance
References: <1B5F013528140F45B5C671039279CA5701F8314C@NANUK.pc.tundra.com>
	<4697E08B.6080700@freescale.com>
In-Reply-To: <4697E08B.6080700@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Wouldn't this cause latencies of up to a second in responding to 
> received packets?  I'd think that would be considered excessive.
> 
> And shouldn't NAPI be reducing the RX interrupt load anyway?

Sorry, I missed that you reduced the interval to 20 ms.  Still, a bit on 
the high side, and a source of wasted CPU cycles when the network isn't 
heavily loaded.  How much of a difference in CPU usage did you see with 
this patch?

-Scott
