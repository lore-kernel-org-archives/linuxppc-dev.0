Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8A4BDE527
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 05:48:16 +1000 (EST)
Message-Id: <A47F7027-7EA3-4A08-82AF-5E5DF5D12684@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200806272135.47167.arnd@arndb.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: Add 83xx and 86xx to 6xx Multiplatform
Date: Fri, 27 Jun 2008 14:47:48 -0500
References: <Pine.LNX.4.64.0806271136240.20344@blarg.am.freescale.net>
	<20080627180423.GB12627@ld0162-tx32.am.freescale.net>
	<200806272135.47167.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 27, 2008, at 2:35 PM, Arnd Bergmann wrote:

> On Friday 27 June 2008, Scott Wood wrote:
>> On Fri, Jun 27, 2008 at 11:36:36AM -0500, Kumar Gala wrote:
>>> There isn't any reason at this point that we can't build 83xx &  
>>> 86xx support
>>> in with the other 6xx based boards.  Twiddle the Kconfigs to allow  
>>> this.
>>
>> Likewise with 82xx -- why don't we just get rid of the "Machine type"
>> choice, and turn them all into bools?
>
> I started looking for possible problems with hardcoded settings for  
> some
> of the platforms, and the only code that looked suspicious in this  
> regard
> was CPM2, but it turned out that this was all because of code built  
> without
> CONFIG_PPC_CPM_NEW_BINDING, which is practically gone in kumar's  
> powerpc-next
> branch.

I've posted patches to remove CONFIG_PPC_CPM_NEW_BINDING, and just  
holding off on the enet ones to see how merging goes w/Jeff.

- k
