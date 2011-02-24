Return-Path: <ppc6dev@digitaldans.com>
Received: from wsl00026.west-datacenter.net (wsl00026.west-datacenter.net
	[69.36.176.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AA75B7093
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2011 07:15:06 +1100 (EST)
Message-Id: <D4328E94-C711-4EE3-9651-E69B359B91B6@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <119fc163-ae81-4492-955a-94d1234ab6d9@VA3EHSMHS021.ehs.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: Flushing data cache on PPC405 in Linux
Date: Thu, 24 Feb 2011 12:15:03 -0800
References: <ef11a825-8824-460f-91c0-82cb8029ed81@VA3EHSMHS029.ehs.local>
	<B5790C8E-AC59-4588-B4C5-A636A4EC1F98@digitaldans.com>
	<119fc163-ae81-4492-955a-94d1234ab6d9@VA3EHSMHS021.ehs.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 24, 2011, at 6:43 AM, John Linn wrote:

> It seems like this also depends on that fact that __GFP_COLD will  
> work,
> otherwise some of the data could
> already be in the cache such that you're not guaranteed to get
> everything out of the cache.

I wouldn't count on GFP_COLD as a guarantee the data isn't
in the cache.  It's likely, but the generic MM functions just
ensures they are old pages, based on an indication from the
caller that freed the pages.


	-- Dan
