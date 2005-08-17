Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id ACEC567FAC
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 18:17:09 +1000 (EST)
Date: Wed, 17 Aug 2005 10:16:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
Message-ID: <Pine.LNX.4.62.0508171016020.6073@numbat.sonytel.be>
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
	linux-kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 Aug 2005, Kumar Gala wrote:
> I'm all for killing it off entirely but got some feedback that on i386
> segment.h can be included by userspace programs.
> 
> Here is the in kernel consumers that are outside of arch specific directories:

> ./drivers/video/q40fb.c:#include <asm/segment.h>

M68k-only, so doesn't affect ppc.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
