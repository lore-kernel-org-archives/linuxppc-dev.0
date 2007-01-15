Return-Path: <SRS0+50d345c2253f972c5556+1240+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB634DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 13:39:27 +1100 (EST)
Subject: Re: [PATCH] Fix performance monitor exception in 2.6.20-series
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168734544.5011.78.camel@localhost.localdomain>
References: <20070113154029.GA32292@eecg.toronto.edu>
	<1168734544.5011.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 10:40:07 +0800
Message-Id: <1168828808.9415.278.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Livio Soares <livio@eecg.toronto.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-01-14 at 11:29 +1100, Benjamin Herrenschmidt wrote:
> 
> Well, are you absolutely sure that nothing will break as a result of
> having a PMU interrupt happening right when it's not expected to ?
> 
> You are basically turning the PMU interrupt into an NMI... I'm not sure
> how safe that is.

If we can _make_ it safe, and in doing so avoid the failure mode where
the machine locks up with interrupts disabled and then the PMU resets
itself entirely (including the date), that might be a good thing...

-- 
dwmw2
