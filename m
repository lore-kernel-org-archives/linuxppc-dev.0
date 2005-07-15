Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id A559B67C36
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 01:29:08 +1000 (EST)
In-Reply-To: <5a4792c00507150714243238da@mail.gmail.com>
References: <5a4792c0050713235574522cfb@mail.gmail.com>
	<E65A8A95-7352-40A3-9A86-EF437F0132D0@freescale.com>
	<5a4792c0050714120571fff071@mail.gmail.com>
	<ef81e8ced15bf8004ec0cd927d7cff8e@onz.com>
	<5a4792c00507150714243238da@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <db98e55b7ed3784ba6bc2bf1d9d81c50@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Fri, 15 Jul 2005 08:29:07 -0700
To: SIP COP 009 <sipcop009@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Here's my serial config..., also these dont show up if i just
> run "make ads8272_defconfig". I have to explicitly go and enable the
> serial options.
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
>
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_CPM is not set
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256

Unless something has changed recently, the 8272 is configured like a 
8260 and uses arch/ppc/8260_io/uart.c. CONFIG_SERIAL_CONSOLE should be 
defined. By default, SMC1 will be your console port. I will very later 
but you may want to have a look for yourself.

Regards
