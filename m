Return-Path: <ctz001@email.mot.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id CE4016884B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 12:06:50 +1100 (EST)
Date: Wed, 30 Nov 2005 19:06:29 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
To: jaap.dejong@nedap.com, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20051201010004.9B1FF68869@ozlabs.org>
Message-ID: <Pine.WNT.4.61.0511301902100.3620@holyoke.labs.mot.com>
References: <20051201010004.9B1FF68869@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: Xilinx_uartlite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm trying to get my avnet virtex4fx12 running with linux.
> It boots, but ends with:
>         Warning: unable to open an initial console.
> This means /dev/console was not opened; init is running.
> Since my board has no 16550 uart I must use xilinx_uartlite
> Part of my configuration:
>         +--Character devices
>                 +--Xilinx UART Lite                     ON
>                 +--Console on UART Lite port            ON
> Any ideas?

/dev/console may not be tied to your UARTLite.  If you don't specify the
console on your kernel command line, try adding something along the lines
of "console=ttyS0,19200" to it (with the appropriate device and baud rate
of course).

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
