Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 59256DE21C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 11:38:59 +1000 (EST)
Date: Thu, 12 Apr 2007 20:56:31 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
Message-ID: <20070413015631.GA11134@lixom.net>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<20070412173334.GP4747@austin.ibm.com>
	<1176403411.28514.55.camel@farscape.rchland.ibm.com>
	<20070412190902.GA8158@lixom.net>
	<1176425143.4734.8.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176425143.4734.8.camel@concordia.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 10:45:43AM +1000, Michael Ellerman wrote:
> On Thu, 2007-04-12 at 14:09 -0500, Olof Johansson wrote:
> > I wasn't going to bring it up since I think it's a good approach as is,
> > but another thing that could be worth considering is to not just go
> > from whatever value to min on every actual input, instead go down in
> > delay a bit (say half the delay). Likewise you might be able to back off
> > more aggressively than just one millisecond per iteration.   Of course,
> > both of these should take min/max values into consideration.
> 
> I experimented with increasing the delay faster (100ms per iteration)
> and found it effected the feel of the console too much when you're
> actually typing. Though perhaps increasing by 10%-20% of the current
> delay every iteration might work OK.

Ok, no need to do it differently then really. I mostly wondered if
someone had already experimented.


-Olof
