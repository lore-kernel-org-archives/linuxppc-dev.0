Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAE20DE21A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 20:52:11 +1000 (EST)
Date: Fri, 22 May 2009 19:51:46 +0900
To: jeremy@goop.org
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <4A15B72E.2070202@goop.org>
References: <4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<4A15B72E.2070202@goop.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090522194930E.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Ian.Campbell@citrix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 May 2009 13:18:54 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Becky Bruce wrote:
> > I can work with that, but it's going to be a bit inefficient, as I 
> > actually need the dma_addr_t, not the phys_addr_t, so I'll have to 
> > convert.  In every case, this is a conversion I've already done and 
> > that I need in the calling code as well.  Can we pass in both the 
> > phys_addr_t and the dma_addr_t?
> 
> The Xen implementation would needs to do the phys to bus conversion page 
> by page anyway, so it wouldn't help much.  But it also wouldn't hurt.
> 
> How expensive is the phys-to-bus conversion on power?  Is it worth 
> making the interface more complex for?  Would passing phys+bus mean that 
> we wouldn't also need to pass dev?

I don't think so. POWERPC needs it.
