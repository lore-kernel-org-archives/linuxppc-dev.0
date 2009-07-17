Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07F78B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 04:15:28 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6HIFOrG007979 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 11:15:25 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n6HIFOII023063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 13:15:24 -0500 (CDT)
Date: Fri, 17 Jul 2009 13:15:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: jerry_dw <jerry_dw@126.com>
Subject: Re: kernel2.6.30 can not boot on my mpc8260 board using u-boot2009.06
Message-ID: <20090717181523.GA3256@b07421-ec1.am.freescale.net>
References: <6174944.80871247795632146.JavaMail.coremail@bj126app32.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6174944.80871247795632146.JavaMail.coremail@bj126app32.126.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2009 at 09:53:52AM +0800, jerry_dw wrote:
> Updating property 'current-speed' =  00 00 25 80                                
> Updating property 'clock-frequency' =  01 79 a7 b0                              
> Updating property 'bus-frequency' =  03 ef 14 80                                
> Updating property 'timebase-frequency' =  00 00 00 00                           

That timebase-frequency doesn't look right...

> BDI2000 console:
> MPC8260|:=>halt
>     Target CPU        : MPC82xx (G2H4)
>     Target state      : debug mode
>     Debug entry cause : COP halt
>     Current PC        : 0xc000c5f0
>     Current CR        : 0x42022088
>     Current MSR       : 0x00001032
>     Current LR        : 0xc001cfa8
> 
> 0xc000c5f0: in hardwareinterrupt vector table.

Which vector (that address looks a little high to be in the exception
vectors)?  Is there anything in the log buffer?

-Scott
