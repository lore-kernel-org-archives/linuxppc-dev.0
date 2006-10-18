Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AED5867B6D
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 08:35:59 +1000 (EST)
Subject: Re: [PATCHES] Ubuntu trivial powerpc patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <ben.collins@ubuntu.com>
In-Reply-To: <1161191250.5663.14.camel@gullible>
References: <1161191250.5663.14.camel@gullible>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:35:46 +1000
Message-Id: <1161210946.10524.12.camel@localhost.localdomain>
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

On Wed, 2006-10-18 at 13:07 -0400, Ben Collins wrote:

> +config EARLY_PROM_PRINT
> +	bool "Support early messages from the kernel via the prom console"
> +	depends PPC_OF
> +	default y
> +	help
> +	  Say Y here to see early messages from the kernel through the
> +	  prom console. These are usually only related to the prom init
> +	  and detection code.
> +

The help text should probably be a little bit less cryptic :) Something
like saying that those messages are displayed by the Open Firmware
wrapper.

Ben.
