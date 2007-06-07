Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s31.bay0.hotmail.com (bay0-omc3-s31.bay0.hotmail.com
	[65.54.246.231]) by ozlabs.org (Postfix) with ESMTP id 751ABDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 21:20:12 +1000 (EST)
Message-ID: <BAY138-F35699348E26C40AED449B3B2260@phx.gbl>
In-Reply-To: <200706071201.46637.arnd@arndb.de>
From: "Ming Liu" <eemingliu@hotmail.com>
To: arnd@arndb.de
Subject: Re: a question on "iowrite32()"
Date: Thu, 07 Jun 2007 11:20:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: domen.puncer@telargo.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Arnd,

>Since of_iomap() is rather new and hardly used by any drivers, we
>could still redefine it so that you would use iowrite32{,be}() instead
>of out_{be,le}32, but currently that doesn't work.

So if I am correct, your suggestion is to use iowrite32be() in my device 
driver, right? However, I cannot find such a function defined in my 2.6.10 
kernel. Isn't iowrite32be() a standard IO function like iowrite32(), or 
there is a patch to export this function?

Thanks for your information.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
