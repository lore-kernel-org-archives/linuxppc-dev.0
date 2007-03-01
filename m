Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57094DDEB7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 12:53:38 +1100 (EST)
In-Reply-To: <45E61161.9040900@gmail.com>
References: <45E5ED35.7090207@gmail.com>
	<0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
	<45E61161.9040900@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eaa8f5754d3e1544ce91df01acf2054d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
Date: Thu, 1 Mar 2007 02:53:29 +0100
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

>  * JohnDeere Vehicleserver (based on pm520 board by microsys) 
> devicetree file
>  * Copyright 2006 Pengutronix
>  * Luotao Fu <l.fu@pengutronix.de>

You removed the original copyright notice, please don't;
it might even be illegal to do so, depending on where
you live/work.  Just add your own, don't remove the original.

> 			interrupt-map = <8000 0 0 1 500 1 1 3 // e100, 10.0
> 			                 8000 0 0 2 500 1 1 3
> 			                 8000 0 0 3 500 1 1 3
> 			                 8000 0 0 4 500 1 1 3

8000 is device 16, not 10

> 			                 8800 0 0 1 500 1 0 3 // usb 11.0, 11.1, 11.2
> 			                 8800 0 0 2 500 1 2 3
> 			                 8800 0 0 3 500 1 3 3
> 			                 8800 0 0 4 500 0 0 3>;

and 8800 is device 17


Your tree looks reasonable otherwise, I didn't look at
the details though.

Hope that helps,


Segher
