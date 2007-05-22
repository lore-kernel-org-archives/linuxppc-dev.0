Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FE6DDDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 06:09:42 +1000 (EST)
Message-ID: <46534DFF.1040709@freescale.com>
Date: Tue, 22 May 2007 15:09:35 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: pterry@micromemory.com
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
In-Reply-To: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Phil Terry wrote:

> 
> srio@c0000 {
>                 device_type = "srio";
>                 compatible = "86xx,85xx";
> 		reg = <c0000 20000>;
> 		law = <400000000 e00000000>;
> 		dbells = <0 ffff>;
> 		mboxs = <0 4>;
>                 interrupt-parent = <&mpic>;
>                 interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
>               };
> 
> where law is the 36-bit start/end address of the law for rapidio (yes I

Generally, the LAWs are configured in the bootloader, which is normally U-Boot.



-- 
Timur Tabi
Linux Kernel Developer @ Freescale
