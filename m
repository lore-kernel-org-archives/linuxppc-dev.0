Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5CC75DDE29
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 01:56:05 +1100 (EST)
Date: Fri, 30 Nov 2007 08:59:29 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 24/24] powerpc: Base support for 440SPe "Katmai" eval board
Message-ID: <20071130145929.GA4196@lixom.net>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130061209.497F3DE03A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071130061209.497F3DE03A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Nov 30, 2007 at 05:11:06PM +1100, Benjamin Herrenschmidt wrote:
> This adds base support for the Katmai board, including PCI-X and
> PCI-Express (but no RTC, nvram, etc... yet).
> 
> Index: linux-work/arch/powerpc/boot/dts/katmai.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/boot/dts/katmai.dts	2007-11-30 14:46:02.000000000 +1100
> @@ -0,0 +1,392 @@
> +/*
> + * Device Tree Source for AMCC Bamboo

No it's not :)



-Olof
