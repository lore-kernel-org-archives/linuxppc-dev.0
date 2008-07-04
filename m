Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B0B8DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 20:28:41 +1000 (EST)
Message-Id: <DEA4DF93-2CC0-4F19-B1CC-59A737626D2B@freescale.com>
From: Timur Tabi <timur@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080630132426.a89c32b0.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] fsl-diu-fb: Update Freescale DIU driver to use
	page_alloc_exact()
Date: Fri, 4 Jul 2008 06:32:05 -0400
References: <1214325853-26150-1-git-send-email-timur@freescale.com>
	<20080630132426.a89c32b0.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 30, 2008, at 4:24 PM, Andrew Morton wrote:

> This is also incorrect.  We cannot pass u64 or uint64_t into printk at
> all.  We do not know what type the architectures uses to implement
> them.  It should be cast to a known type.  In this case `unsigned long
> long'.

Ok, I'll fix these, but I'm on vacation now and won't get to it for  
another 10 days.
