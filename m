Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm8mk48z0zDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 22:49:09 +1000 (AEST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, nicolas.ferre@microchip.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] video: fbdev: annotate fb_fix_screeninfo with const and
 __initconst
Date: Mon, 04 Sep 2017 14:40:31 +0200
Message-id: <17101194.VCoQWdOLM3@amdc3058>
In-reply-to: <1503251091-23485-1-git-send-email-bhumirks@gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <CGME20170820193005epcas2p3fe5314badbe003db0b74b0f9fde40e9f@epcas2p3.samsung.com>
 <1503251091-23485-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday, August 20, 2017 11:14:51 PM Bhumika Goyal wrote:
> Make these const as they are only used during a copy operation.
> Some structures are used as a copy operation inside __init functions, so
> make them const and replace __initdata with __initconst to avoid section
> conflict error.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
