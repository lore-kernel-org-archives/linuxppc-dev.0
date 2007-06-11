Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 73535DDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 03:46:03 +1000 (EST)
Date: Mon, 11 Jun 2007 10:46:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Don't register udbg_console without udbg_putc
Message-ID: <20070611174617.GA7093@mag.az.mvista.com>
References: <111814499636b8b45671.846930886.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <111814499636b8b45671.846930886.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 09, 2007 at 11:32:43PM -0500, Milton Miller wrote:
> Previously, registering this early console would just result
> in dropping early buffered printk output until a udbg_putc
> was registered.
> 
> However, commit 69331af79cf29e26d1231152a172a1a10c2df511
> clears the CON_PRINTBUFFER flag on the main console when a
> CON_BOOT (early) console has been registered, resulting in
> the buffered messages never being displayed to the user.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Mark A. Greer <mgreer@mvista.com>

> 
> --- 
> Mark and Dale can you test this please?

Yep, get all the console output with this patch and non of Dales
patches.

Thanks Milton,

Mark
