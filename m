Return-Path: <marek.vasut@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9r9B3nYzzDvX7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 18:35:58 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id p190so7154244wmp.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Nov 2016 00:35:58 -0700 (PDT)
Subject: Re: [PATCH 00/22] mtd: nand: return error code of nand_scan(_ident,
 _tail) on error
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-mtd@lists.infradead.org
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Josh Wu <rainyfeeling@outlook.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 Vladimir Zapolskiy <vz@mleia.com>, Wenyou Yang <wenyou.yang@atmel.com>,
 linux-mediatek@lists.infradead.org,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <7970b05b-a5d4-4149-ba80-f6d19a145c6d@gmail.com>
Date: Sat, 5 Nov 2016 08:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2016 11:42 AM, Masahiro Yamada wrote:
> 
> nand_scan(), nand_scan_ident(), nand_scan_tail() return
> an appropriate negative value on error.
> 
> Most of drivers return the value from them on error,
> but some of them return the fixed error code -ENXIO
> (and a few return -ENODEV).
> 
> This series make those drivers return more precise error code.
> 

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

Nice cleanup, thanks!

-- 
Best regards,
Marek Vasut
