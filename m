Return-Path: <jes@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 2E081DDF3B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 18:40:58 +1000 (EST)
Message-ID: <4847A690.302@sgi.com>
Date: Thu, 05 Jun 2008 10:40:48 +0200
From: Jes Sorensen <jes@sgi.com>
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop> <4843C3D7.7000609@sgi.com>
	<200806031433.12460.nickpiggin@yahoo.com.au>
	<200806030952.10360.jbarnes@virtuousgeek.org>
In-Reply-To: <200806030952.10360.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	Jeremy Higdon <jeremy@sgi.com>,
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

Jesse Barnes wrote:
> Now, in hindsight, using a PIO write set & test flag approach in 
> writeX/spin_unlock (ala powerpc) might have been a better approach, but iirc 
> that never came up in the discussion, probably because we were focused on PCI 
> posting and not uncached vs. cached ordering.

Hi Jesse,

I am going to take a stab at implementing this so we can see how much
of an impact it will have.

Cheers,
Jes
