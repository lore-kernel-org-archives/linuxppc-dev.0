Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 03FC968221
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2005 02:16:47 +1000 (EST)
Date: Wed, 31 Aug 2005 09:17:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050831161726.GA6095@mag.az.mvista.com>
References: <20050830233205.GB24345@xyzzy.farnsworth.org>
	<20050831055934.871E41C00097@mwinf1107.wanadoo.fr>
	<20050831160417.GA3848@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831160417.GA3848@mag.az.mvista.com>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-dev@ozlabs.org
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2005 at 09:04:17AM -0700, Mark A. Greer wrote:
> The enet->mem BARs are configured in
> arch/ppc/syslib/mv64xc60.c:mv64360_config_io2mem_windows().

Doh, that should be arch/ppc/syslib/mv64x60.c:...

> IMHO, the platform file should be where things like that belong.

Should be, "IMHO, the platform file *is* where things like that belong."

Mark
