Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7DFC468672
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2005 15:26:40 +1100 (EST)
Date: Thu, 3 Nov 2005 20:25:24 -0800
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051104042524.GD8515@pb15.lixom.net>
References: <20051103183256.GJ3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051103183256.GJ3839@smtp.west.cox.net>
From: Olof Johansson <olof@lixom.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Allow for bigger compressed kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 03, 2005 at 11:32:56AM -0700, Tom Rini wrote:

> --- a/arch/ppc/boot/simple/misc.c
> +++ b/arch/ppc/boot/simple/misc.c
> @@ -7,10 +7,10 @@
>   * your serial console.  If a machine meets these requirements, it can quite
>   * likely use this code during boot.
>   *
> - * Author: Matt Porter <mporter@mvista.com>
> + * Author: Tom Rini <trini@mvista.com>
>   * Derived from arch/ppc/boot/prep/misc.c

I understand adding authors to a file when code is added, but why should
author credit be removed?


-Olof
