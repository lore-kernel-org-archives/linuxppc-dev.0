Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9244FDDFC8
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 07:41:53 +1000 (EST)
Message-Id: <DC91BA72-AF10-41DD-B610-EDEFD106A811@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <49EF8D42.7010104@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: removing get_immrbase()??
Date: Wed, 22 Apr 2009 16:39:46 -0500
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8D42.7010104@freescale.com>
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


On Apr 22, 2009, at 4:33 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> I disagree.  If you update your kernel you should update your device
>> tree (thus we have .dts in the kernel tree and not somewhere else).
>
> Is this a new policy?  I was under the impression that supporting  
> older
> device trees, if not too inconvenient, is desirable.  I've nack'd
> patches before that broke backwards compatibility unnecessarily.

The specific issue I'm talking about is the addition of new nodes that  
might break old device trees.  I have no desire to try and say that I  
can't add new nodes and code related to them just because old device  
tree's didn't have them.

- k
