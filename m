Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id 8FEFD67C5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 13:05:05 +1000 (EST)
In-Reply-To: <5a4792c0050714120571fff071@mail.gmail.com>
References: <5a4792c0050713235574522cfb@mail.gmail.com>
	<E65A8A95-7352-40A3-9A86-EF437F0132D0@freescale.com>
	<5a4792c0050714120571fff071@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ef81e8ced15bf8004ec0cd927d7cff8e@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Thu, 14 Jul 2005 20:05:03 -0700
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

> => setenv bootargs console=ttyCPM0,115200  root=/dev/ram
> => bootm fe600000
> ## Booting image at fe600000 ...
>    Image Name:   2.6.12 for 8272
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    875845 Bytes = 855.3 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>

Can you provide your kernel configuration information regarding the 
serial ports. Which serial port is your console port? Check the 
following configuration options:
   CONFIG_SERIAL_CONSOLE
   CONFIG_SCC_CONSOLE
   CONFIG_SERIAL_CORE
   CONFIG_SERIAL_CORE_CONSOLE

Another observation is that you are trying to boot with a RAM disk but 
you have not provided the RAM disk address to the bootm command. This 
is not your current problem since you don't get that far.

- Allen
