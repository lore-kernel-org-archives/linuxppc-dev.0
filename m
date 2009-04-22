Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6F85DDF81
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 06:20:34 +1000 (EST)
Message-ID: <49EF7C0D.4040509@freescale.com>
Date: Wed, 22 Apr 2009 15:20:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
In-Reply-To: <49EF7B1C.2080105@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Scott Wood wrote:
>> Timur Tabi wrote:
>>>>        these two are related and seem like we could look for "fsl,cpm2"
>>> That's okay, as long as you don't break compatibility with older
>>> device trees that don't have that property, unless you can demonstrate
>>> that these trees would never work with the current kernel anyway.
>> All CPM2 device trees should have fsl,cpm2 listed in the compatible of 
>> the CPM node.
> 
> Yes, but did they always have that compatible field? 

Yes, except for trees from the previous era of CPM2 bindings which are 
not supported at all.  This isn't new.

-Scott
