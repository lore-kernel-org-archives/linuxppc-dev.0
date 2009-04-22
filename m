Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CFAEDDFC8
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 07:59:00 +1000 (EST)
Message-ID: <49EF92E6.4090301@freescale.com>
Date: Wed, 22 Apr 2009 16:57:58 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8D42.7010104@freescale.com>
	<DC91BA72-AF10-41DD-B610-EDEFD106A811@kernel.crashing.org>
	<49EF9019.7000102@freescale.com>
	<C86B0B8A-C031-4F4C-AF79-58D77ED6EA2F@kernel.crashing.org>
In-Reply-To: <C86B0B8A-C031-4F4C-AF79-58D77ED6EA2F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> New nodes.  For example I've proposed a "local access window" node.   
> Once I add it I plan on changing code to use it.  This will break an  
> old device tree booting with the new kernel and I'm completely ok with  
> that.

Are we having two different conversations?  I was talking about this
block from your email:

>> arch/powerpc/include/asm/cpm2.h:#define CPM_MAP_ADDR (get_immrbase() +
>> 0x80000)
>> arch/powerpc/sysdev/cpm2.c:     cpm2_immr = ioremap(get_immrbase(),
>> CPM_MAP_SIZE);
>>        these two are related and seem like we could look for "fsl,cpm2"
> 
> That's okay, as long as you don't break compatibility with older
> device trees that don't have that property, unless you can demonstrate
> that these trees would never work with the current kernel anyway.

Specifically, I was referring to this comment:
	
	these two are related and seem like we could look for "fsl,cpm2"

And my point was that not all device trees have "fsl,cpm2" in their CPM
nodes.
	
-- 
Timur Tabi
Linux kernel developer at Freescale
