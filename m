Return-Path: <jes@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id DA249DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 19:48:18 +1000 (EST)
Message-ID: <4843C1DB.4080500@sgi.com>
Date: Mon, 02 Jun 2008 11:48:11 +0200
From: Jes Sorensen <jes@sgi.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<1212097223.8888.55.camel@pasglop> <483FCD5C.208@sgi.com>
	<20080531081450.GI5405@ucw.cz>
In-Reply-To: <20080531081450.GI5405@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pavel Machek wrote:
> Still better than changing semantics of writel for _all_ drivers.
> 
> If you are really sure driver does not depend on writel order, it is
> just a sed/// command, so I don't see any big code maintenance
> issues...

This isn't changing the semantics for all drivers, it means it leaves
it up to us to fix the drivers that hit the problem. Whereas the other
way round we'd have to make some fairly big modifications to a large
number of drivers, which the driver maintainers are likely to be
reluctant to accept and maintain. It will be a constant chase to keep
that in order.

Cheers
Jes
