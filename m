Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 48785DDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 00:01:21 +1100 (EST)
Date: Mon, 11 Feb 2008 16:01:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] MPC8360E-RDK: device tree,
	board file and defconfig
Message-ID: <20080211130132.GA6445@localhost.localdomain>
References: <20080201135640.GA10966@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080201135640.GA10966@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 04:56:40PM +0300, Anton Vorontsov wrote:
> This is new board made by Freescale Semiconductor Inc. and
> Logic Product Development.
> 
> Currently supported:
> 1. UEC{1,2,7,4};
> 2. I2C;
> 3. SPI;
> 4. NS16550 serial;
> 5. PCI and miniPCI;
> 6. Intel NOR StrataFlash X16 64Mbit PC28F640P30T85;
> 7. Graphics controller, Fujitsu MB86277.
> 
> Not supported so far:
> 1. StMICRO NAND512W3A2BN6E, 512 Mbit (supported with FSL UPM patches);
> 2. QE Serial UCCs (tested to not work with ucc_uart driver, reason
>    unknown, yet);
> 3. ADC AD7843 (tested to work, but support via device tree depends on
>    major SPI rework, GPIO API, etc);
> 4. FHCI USB (will send RFC patches soon).
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Hello Kumar,
> 
> It would be great if we can get this into the 2.6.25.

Is there any chance this will hit 2.6.25?..

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
