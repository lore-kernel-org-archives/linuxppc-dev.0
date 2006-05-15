Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 0D4DF67B42
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 16:08:18 +1000 (EST)
In-Reply-To: <1147657558.21291.65.camel@localhost.localdomain>
References: <87wtcplejw.fsf@blackdown.de>
	<17510.55656.607530.491585@zot.electricrain.com>
	<1147657558.21291.65.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D0930F4F-DF46-47FF-B33C-0BE313CC81DB@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Load average 1.0 on idle machine
Date: Mon, 15 May 2006 02:08:13 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, "Brian D. Carlstrom" <bdc@carlstrom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 14, 2006, at 9:45 PM, Benjamin Herrenschmidt wrote:

> ....   For now, consider
> the load avergage value bogus :)

It's not bogus :-)  If you happen to schedule periodic
tasks that are sampled with load average computes,
or sleep them "uninterrupible", they are counted in
the load average.


	-- Dan
