Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 31B21B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 19:29:00 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pmac_zilog: Workaround problem due to interrupt on closed
	port
Date: Mon, 11 Jan 2010 02:28:50 -0600
References: <1263181902.724.94.camel@pasglop>
In-Reply-To: <1263181902.724.94.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201001110228.52201.rob@landley.net>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 10 January 2010 21:51:42 Benjamin Herrenschmidt wrote:
> It seems that in qemu, we can see an interrupt in R3 despite the
> fact that it's masked in W1. The chip doesn't actually issue an
> interrupt, but we can "see" it when taking an interrupt for the
> other channel. This may be a qemu bug ... or not, so let's be
> safe and avoid calling into the UART layer when that happens which
> woulc cause a crash.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Rob Landley <rob@landley.net>

Tested it, and it worked for me.

Thanks,

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
