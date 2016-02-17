Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by lists.ozlabs.org (Postfix) with ESMTP id B7B6A1A0331
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 21:54:52 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, linux-serial@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-media@vger.kernel.org
Subject: Re: [PATCH 0/7] fix IS_ERR_VALUE usage
Date: Wed, 17 Feb 2016 11:48:38 +0100
Message-ID: <7443859.JK6ybmGO1A@wuerfel>
In-Reply-To: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 15 February 2016 15:35:18 Andrzej Hajda wrote:
> 
> Andrzej Hajda (7):
>   netfilter: fix IS_ERR_VALUE usage
>   MIPS: module: fix incorrect IS_ERR_VALUE macro usages
>   drivers: char: mem: fix IS_ERROR_VALUE usage
>   atmel-isi: fix IS_ERR_VALUE usage
>   serial: clps711x: fix IS_ERR_VALUE usage
>   fbdev: exynos: fix IS_ERR_VALUE usage
>   usb: gadget: fsl_qe_udc: fix IS_ERR_VALUE usage
> 

Can you Cc me the next time on all of the patches? I only got
three of them this time.

	Arnd
