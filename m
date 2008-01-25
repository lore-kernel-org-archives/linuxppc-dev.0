Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADECBDDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:41:23 +1100 (EST)
Date: Fri, 25 Jan 2008 02:38:55 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/10] Support for SBC834x/8548/8560 Wind River Boards
In-Reply-To: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <Pine.LNX.4.64.0801250238440.9533@blarg.am.freescale.net>
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Paul Gortmaker wrote:

>
> This series contains the patches for the Wind River SBC834x, SBC8548 and
> SBC8560, grouped together for merge convenience.
>
> Changes since previous:
>
> sbc834x:
> 	- machine_device_initcall as per Kumar's recent commit 6392f184
> 	- remove four device_type from dts that DavidG wanted gone.
> 	- add of_node_put() and __initdata as per StephenR's suggestions.
>
> sbc8548:
> 	- fold the dts, and conversion to dts-v1, into a single commit
>
> sbc8560:
> 	- dts has localbus with 2 address cells (chipsel) and epld as child
> 	- UART detection legacy_serial patch separated out from 8560 patches
> 	- fold the dts, and conversion to dts-v1, into a single commit
>
> I've boot tested these all on "for-2.6.25" to make sure things are sane.
> Thanks again to those who have suggested improvements and changes.

applied.

- k
