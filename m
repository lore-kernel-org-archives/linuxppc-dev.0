Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF616DDEDC
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 23:54:15 +1100 (EST)
In-Reply-To: <45E69CDF.20608@gmail.com>
References: <45E5ED35.7090207@gmail.com>
	<0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
	<45E61161.9040900@gmail.com>
	<eaa8f5754d3e1544ce91df01acf2054d@kernel.crashing.org>
	<45E69CDF.20608@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3a8c70b34f2ef98fb696c371b4d2c2d2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
Date: Thu, 1 Mar 2007 13:54:07 +0100
To: Luotao Fu <devtty0@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>             interrupt-map = <8000 0 0 1 500 1 1 3 // e100, 10.0
>>>                              8000 0 0 2 500 1 1 3
>>>                              8000 0 0 3 500 1 1 3
>>>                              8000 0 0 4 500 1 1 3
>>
>> 8000 is device 16, not 10

<snip>

> I got the address 8000 here. Is the
> pdev->bus->number actually supposed to be 10 for device 10? I had some
> trouble tracking down how the bus number is initialized. It might be
> nice if you or some one could give me a hint on this.

8000 is device 16 is 0x10 hex.  PCI device numbers are
usually written in decimal.  Is your device 10 == 0x0a
or 16 == 0x10?


Segher
