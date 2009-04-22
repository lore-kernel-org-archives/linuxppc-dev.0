Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C85ADDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 07:57:48 +1000 (EST)
Message-Id: <5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49EF8E3A.4060304@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: removing get_immrbase()??
Date: Wed, 22 Apr 2009 16:55:42 -0500
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 4:38 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> I disagree.  If you update your kernel you should update your  
>> device tree (thus we have .dts in the kernel tree and not somewhere  
>> else).
>
> No.  The device tree is a means to pass information from the  
> firmware to the kernel.  It is part of the firmware.  That the  
> repository of trees is in the Linux kernel for any boards which are  
> not including the tree inside a bootwrapper is a historical accident.

I think its a point of view argument.  I don't agree its part of the  
firmware, at least not part of the firmware we use (u-boot).

> Updating the dtb with the kernel just shifts the risk of  
> incompatibility to interactions between the firmware and the dtb.   
> The same backwards compatibility considerations when making kernel  
> changes that depend on firmware changes should be made when making  
> kernel changes that depend on dts changes.

As I told Timur, I'm speaking of addition of new nodes and code that  
parses and expect those nodes to be there.

- k
