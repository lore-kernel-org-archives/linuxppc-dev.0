Return-Path: <SRS0+50d345c2253f972c5556+1240+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19301DDE2B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 14:14:03 +1100 (EST)
Subject: Re: [PATCH] Fix performance monitor exception in 2.6.20-series
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17834.60612.793025.590958@cargo.ozlabs.ibm.com>
References: <20070113154029.GA32292@eecg.toronto.edu>
	<1168734544.5011.78.camel@localhost.localdomain>
	<1168828808.9415.278.camel@shinybook.infradead.org>
	<17834.60612.793025.590958@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 11:14:20 +0800
Message-Id: <1168830860.9415.284.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Livio Soares <livio@eecg.toronto.edu>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-15 at 13:53 +1100, Paul Mackerras wrote:
> Different PMU, I think; they are talking about the Performance Monitor
> Unit in POWERx cpus. 

Ah, OK. That makes the "doesn't do anything you can't do in an NMI"
assessment make a little more sense to me.

Still, might be worth thinking about whether we can make the Apple PMU
into an NMI to help prevent the error case I mentioned.

-- 
dwmw2
