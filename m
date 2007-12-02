Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 581D6DDDFC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 12:31:04 +1100 (EST)
Subject: Re: serial console autodetection not working on powermac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20071201144021.GA13898@aepfle.de>
References: <20071201144021.GA13898@aepfle.de>
Content-Type: text/plain
Date: Sun, 02 Dec 2007 12:11:19 +1100
Message-Id: <1196557879.13230.149.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-12-01 at 15:40 +0100, Olaf Hering wrote:
> How is the serial console autodetection supposed to work with current
> kernels? arch/powerpc/kernel/legacy_serial.c is not compiled unless
> CONFIG_PPC_UDBG_16550 is selected.
> Even if I force this config option, legacy_serial_console remains -1 and
> the ch-a/ch-b check in check_legacy_serial_console() does not trigger.
> Can the ch-a/ch-b check in check_legacy_serial_console() trigger anyway?
> 
> The autodetection used to work in earlier kernels.
> 
> A compiletime check for CONFIG_SERIAL_PMACZILOG_TTYS is also required,
> to switch between ttyS and ttyPZ. Currently ttyS is hardcoded.

It might well have bitrotted. It should be taken out of that file
anyway. I'll have a look next week. Remind me if I forget :-)

Ben.
