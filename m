Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1BA0EDDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 17:44:20 +1000 (EST)
Date: Thu, 10 May 2007 09:44:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: Fixup hard_irq_disable semantics
In-Reply-To: <20070510052620.EC36DDDF92@ozlabs.org>
Message-ID: <Pine.LNX.4.62.0705100942590.32241@pademelon.sonytel.be>
References: <20070510052620.EC36DDDF92@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007, Benjamin Herrenschmidt wrote:
> This patch renames the raw hard_irq_{enable,disable} into
> __hard_irq_{enable,disable} and introduces a higher level
> hard_irq_disable() function that can be used by any code
> to enforce that IRQs are fully disabled, not only lazy
> disabled.

Why did you rename hard_irq_enable() too?

Isn't it more logical to have high-level hard_irq_disable() and
hard_irq_enable(), and a special low-level __hard_irq_disable()?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
