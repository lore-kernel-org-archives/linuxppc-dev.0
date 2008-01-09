Return-Path: <Haiying.Wang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62C6EDDEE0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 01:18:30 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m09EETgi013424
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 07:18:26 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m09EESjd007327
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 08:14:28 -0600 (CST)
Subject: Re: printk() does not work on UART1
From: Haiying Wang <Haiying.Wang@freescale.com>
To: mike zheng <mail4mz@gmail.com>
In-Reply-To: <5c9cd53b0801082106p7b57e11ejc809c182a26599d5@mail.gmail.com>
References: <5c9cd53b0801081611ve59e9a8q6ae2fd227bfc0ed8@mail.gmail.com>
	<5c9cd53b0801082106p7b57e11ejc809c182a26599d5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 09:14:28 -0500
Message-Id: <1199888068.3004.3.camel@udp097527uds.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-01-09 at 00:06 -0500, mike zheng wrote:
>  Hi All,
> 
>  I have one mpc8568 board using UART1 as the serial port.  The OS is
>  Linux Kernel2.4.  If I use the polling mode driver of
>  gen550_progress(), it works fine. However the printk() does not work
>  after the console_init(). Anyone know what shall I change in the
>  kernel to use UART1 as serial console? I assume the default is UART0,
>  but I don't know where the value is set. I changed the CONFIG_CMDLINE
>  to ttyS1, it does NOT work.

Make sure you've configured PC0/1/2/3 for UART1 SOUT/RTS/CTS/SIN in
u-boot.

Haiying
