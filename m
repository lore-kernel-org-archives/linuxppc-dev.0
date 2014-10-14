Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B3B71A040E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 18:58:51 +1100 (EST)
Message-ID: <1413273473.26478.52.camel@pasglop>
Subject: Re: [PATCH 1/4] powerpc: Dynamic DMA zone limits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 14 Oct 2014 18:57:53 +1100
In-Reply-To: <1413272346.2878.2.camel@aoeu.buserror.net>
References: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
 <20141013181436.300988c8@kryten> <1413190849.21457.4.camel@concordia>
 <1413272346.2878.2.camel@aoeu.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-14 at 09:39 +0200, Scott Wood wrote:
> For a short-term workaround, I'd rather leave CONFIG_ZONE_DMA32 where
> it
> is and put #ifdef CONFIG_FSL_SOC (with a comment) around the whole
> thing.

I'd like to not enable CONFIG_ZONE_DMA32 when we don't need it, ie,
on !BOOKE 64-bit

Cheers,
Ben.
