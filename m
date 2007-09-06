Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D40E9DDF3B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 07:01:22 +1000 (EST)
In-Reply-To: <20070906205137.299990@gmx.net>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
	<22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
	<20070906141501.GA16353@ld0162-tx32.am.freescale.net>
	<20070906205137.299990@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0273875e24b3ede33430f47f9babdff4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PCI I/O space -- reg or ranges?
Date: Thu, 6 Sep 2007 23:01:17 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Sure, it can be encoded like that.  But does it make sense?
>>> You cannot use legacy I/O space as normal memory space.
>>
>> Why does it not make sense?  I'm not sure what you mean by using it as
>> "normal memory space", but if the PCI bridge does a straightforward
>> linear mapping of I/O into memory space (like most non-x86 bridges 
>> do),
>> it seems to make sense to me to reuse the existing ranges mechanism
>> rather than require each driver to have extra glue code.
> Well, pci_process_bridge_OF_ranges() only looks at the ranges property 
> to
> ioremap() I/O space.

That's because it is the function that process the "ranges"
property, like its name shows ;-)


Segher
