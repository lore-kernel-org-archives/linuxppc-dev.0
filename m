Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 7D008DE89E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 04:12:07 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so114835uge.0
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 11:12:01 -0700 (PDT)
Message-ID: <4808E469.9020408@genesi-usa.com>
Date: Fri, 18 Apr 2008 19:11:53 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>	<200804171619.56615.jbe@pengutronix.de>	<4808C1BE.1050607@fang.fa.gau.hu>
	<200804181802.34833.jbe@pengutronix.de>
In-Reply-To: <200804181802.34833.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Juergen Beisert wrote:
> On Friday 18 April 2008 17:43, Peter Czanik wrote:
> I'm not sure if "cell-index" is a correct property. I copied it from the uart 
> driver, because this driver needs something to distinguish between PSC1 and 
> PSC2. Maybe there is a better and correct oftree solution? Any oftree expert 
> here?

cell-index is correct by legacy, but I think it has been said by that you could
just as well pick which PSC you are running on by it's address.

I would prefer the address approach, but everyone's going to keep cell-index
around anyway so why not leave it there and why not keep using it?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
