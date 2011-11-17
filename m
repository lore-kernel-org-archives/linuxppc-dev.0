Return-Path: <dedekind1@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E001DB7274
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 09:08:19 +1100 (EST)
Received: by bkat8 with SMTP id t8so2622357bka.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 14:08:13 -0800 (PST)
Subject: Re: [PATCH 1/3] mtd/nand: fix coding style issue in
 drivers/mtd/nand/fsl_elbc.c
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Fri, 18 Nov 2011 00:08:08 +0200
In-Reply-To: <1321349355-1639-1-git-send-email-b35362@freescale.com>
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321567690.2272.24.camel@koala>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, scottwood@freescale.com,
 akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-15 at 17:29 +0800, b35362@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> fix whitespaces,tabs coding style issue and use #include <linux/io.h> instead of <asm/io.h>
> in drivers/mtd/nand/fsl_elbc.c.
> 
> Signed-off-by: Liu Shuo <b35362@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Hi, It is really matter of taste whether to use only tabs for
indentations or tabs + few spaces to align nicely with the previous
line. I personally prefer the latter and dislike when people use only
tabs. But other people love tabs and use them everywhere, even like
#define\tBLAH_BLAH\tvalue, which I find ugly, but I do not mind people
using this.

So no, please, let's leave the indentation as is in this file. It is ok
to assume tab is 8 spaces in the kernel.

Artem.
