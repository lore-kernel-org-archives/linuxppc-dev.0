Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B726DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 00:25:50 +1100 (EST)
Message-Id: <78E0E730-922B-43E2-8FF3-D720A70B211B@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1238564280.17330.119.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Broken CONFIG_HIGHPTE
Date: Wed, 1 Apr 2009 08:25:27 -0500
References: <1238564280.17330.119.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2009, at 12:38 AM, Benjamin Herrenschmidt wrote:

> Hi !
>
> Just noticed... And I'll be travelling for a while so with no much
> time to look at it.
>
> Your changes to use the PTE page free batch via RCU on ppc32 broke
> CONFIG_HIGHPTE for hash32...
>
> You rely on passing a page_address() of the PTE page down to the
> freeing layer. That doesn't work for highmem pages. That needs to
> be changes to a struct page * on 32-bit (not on 64-bit where we
> are using slabs though)

I can look into this, how does this show up?

- k
