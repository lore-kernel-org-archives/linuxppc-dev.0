Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51D03DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:19:48 +1100 (EST)
Date: Fri, 25 Jan 2008 02:17:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc: reduce code duplication in legacy_serial, add
	UART parent types
In-Reply-To: <20080124224043.GA418@windriver.com>
Message-ID: <Pine.LNX.4.64.0801250216530.9153@blarg.am.freescale.net>
References: <200801172335.48817.arnd@arndb.de>
	<12011947821738-git-send-email-paul.gortmaker@windriver.com>
	<20080124224043.GA418@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Thu, 24 Jan 2008 11:59:12 -0500
> Subject: [PATCH] powerpc: reduce code duplication in legacy_serial, add UART parent types
>
> The legacy_serial was treating each UART parent in a separate code block.
> Rather than continue this trend for the new parent IDs, this condenses
> all (soc, tsi, opb, plus two more new types) into one of_device_id array.
> The new types are wrs,epld-localbus for the Wind River sbc8560, and a
> more generic "simple-bus" as requested by Scott Wood.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/kernel/legacy_serial.c |   45 +++++++++++++---------------------
>  1 files changed, 17 insertions(+), 28 deletions(-)
>
applied

- k
