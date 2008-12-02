Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C70ACDDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 20:43:36 +1100 (EST)
Date: Tue, 2 Dec 2008 10:31:14 +0100
From: Alessandro Rubini <rubini-list@gnudd.com>
To: nvbolhuis@aimvalley.nl
Subject: Re: [U-Boot] NAND only (no NOR)
Message-ID: <20081202093114.GA25146@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini-list@gnudd.com
In-Reply-To: <4934F7FC.2030105@aimvalley.nl>
References: <4934F7FC.2030105@aimvalley.nl> 
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disclaimer: I'm not running ppc these days

> However, having no NOR flash means:
>   - NAND should be programmable via JTAG (BDI3000 doesn't support
>     this, Lauterbach/trace32 does)

My personal preference for bringing up a new board is placing u-boot
in RAM using the available information to setup SDRAM from the jtag
tool (or, better, place the initial boot code the manufacturer give
you in static memory, and jump to is with a breakpoint in the right
place).

While my debugger is able to write flash, I've always found it easier
to do that from u-boot itself. Besides, I can fix my u-boot in RAM
without the lengthy erase-reprogram cycles.

If you work like this, it's irrelevant whether it is nor, nand or dataflash
or whatever, as long as u-boot is able to manage it.

hope this helps
/alessandro
