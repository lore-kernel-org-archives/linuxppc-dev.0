Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66EB42BDA5
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2004 17:47:26 +1000 (EST)
Date: Wed, 20 Oct 2004 09:46:51 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041020094651.5ceff814@pirandello>
In-Reply-To: <1098168058.15029.45.camel@gaston>
References: <20041018232004.0a9e0d5e@jack.colino.net>
	<1098143379.18687.44.camel@gaston>
	<20041019083432.01b947d3@pirandello>
	<1098168058.15029.45.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: PMU questions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 19 Oct 2004 at 16h10, Benjamin Herrenschmidt wrote:

Hi Ben, 

> > > Then, do a full charge, and drain it again completely. 
> > > Do that a few times. 
> > 
> > Without resetting the PMU ?
> 
> Yes

Thanks for your advice, it works a bit. I started with a
max_charge : 597

After the first charge/drain it went up to 
max_charge : 1854

Strangely enough after a second cycle it's now
max_charge : 1573

I can't find a logic in this stuff... Do you think there's a special
reason why Apple uses such a complicated method instead of 
a) charging until voltage stays equals for a few minutes
b) draining until voltage goes under 13.5 volts (or 13, or whatever)

In my uninformed opinion that would work better, wouldn't it?

-- 
Colin
