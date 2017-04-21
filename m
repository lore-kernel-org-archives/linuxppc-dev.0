Return-Path: <b.zolnierkie@samsung.com>
Received: from epoutp02.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8fDL32YgzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 01:05:05 +1000 (AEST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video: console: Remove reference to CONFIG_8xx
Date: Fri, 21 Apr 2017 16:57:37 +0200
Message-id: <4573665.CQJldHZTyj@amdc3058>
In-reply-to: <20170414135004.46D646831E@localhost.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <CGME20170414135008epcas1p306041aaebadfbb6d68183d8866639a9e@epcas1p3.samsung.com>
 <20170414135004.46D646831E@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, April 14, 2017 03:50:04 PM Christophe Leroy wrote:
> CONFIG_8xx is deprecated and should soon be removed in favor
> of CONFIG_PPC_8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
