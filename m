Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id 8BA9668862
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 18:13:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 1 Dec 2005 08:13:11 +0100
Message-ID: <6915D0AE8B9047438F320B466AE30FDD324CCD@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: "T Ziomek" <ctz001@email.mot.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: RE: Xilinx_uartlite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tom,

Thanks for your reply, but then I only get:
	Now booting the kernel

Beste regards,

Jaap

-----Oorspronkelijk bericht-----
Van: T Ziomek [mailto:ctz001@email.mot.com]=20
Verzonden: donderdag 1 december 2005 02:06
Aan: Jaap de Jong; linuxppc-embedded
Onderwerp: Re: Xilinx_uartlite

> I'm trying to get my avnet virtex4fx12 running with linux.
> It boots, but ends with:
>         Warning: unable to open an initial console.
> This means /dev/console was not opened; init is running.
> Since my board has no 16550 uart I must use xilinx_uartlite Part of my

> configuration:
>         +--Character devices
>                 +--Xilinx UART Lite                     ON
>                 +--Console on UART Lite port            ON
> Any ideas?

/dev/console may not be tied to your UARTLite.  If you don't specify the
console on your kernel command line, try adding something along the
lines of "console=3DttyS0,19200" to it (with the appropriate device and
baud rate of course).

Tom
--=20
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
