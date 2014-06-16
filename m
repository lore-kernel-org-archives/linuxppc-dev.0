Return-Path: <jg1.han@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F41D41A0336
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 22:38:11 +1000 (EST)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7900AC4HAQUK20@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 16 Jun 2014 21:28:03 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrzej Hajda' <a.hajda@samsung.com>, 'Lee Jones' <lee.jones@linaro.org>,
 'Bryan Wu' <cooloney@gmail.com>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
In-reply-to: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
Subject: Re: [PATCH 0/2] backlight: remove trivial get_brightness
 implementations
Date: Mon, 16 Jun 2014 21:28:02 +0900
Message-id: <000701cf895e$6a648f20$3f2dad60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: 'Milo Kim' <milo.kim@ti.com>,
 "'open list:FRAMEBUFFER LAYER'" <linux-fbdev@vger.kernel.org>,
 "'open list:X86 PLATFORM DRIVERS'" <platform-driver-x86@vger.kernel.org>,
 'Thierry Reding' <thierry.reding@gmail.com>,
 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>,
 'Yijing Wang' <wangyijing@huawei.com>,
 'Matthew Garrett' <matthew.garrett@nebula.com>,
 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>,
 'Jingoo Han' <jg1.han@samsung.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>,
 'Geert Uytterhoeven' <geert@linux-m68k.org>,
 'Daniel Vetter' <daniel.vetter@ffwll.ch>,
 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>,
 'Dan Carpenter' <dan.carpenter@oracle.com>,
 "'open list:PWM SUBSYSTEM'" <linux-pwm@vger.kernel.org>,
 "'moderated list:ARM/S5P EXYNOS AR...'" <linux-samsung-soc@vger.kernel.org>,
 'Mikulas Patocka' <mpatocka@redhat.com>,
 "'moderated list:ARM/S5P EXYNOS AR...'" <linux-arm-kernel@lists.infradead.org>,
 'Randy Dunlap' <rdunlap@infradead.org>,
 'open list' <linux-kernel@vger.kernel.org>, 'Rob Clark' <robdclark@gmail.com>,
 'Jon Mason' <jdmason@kudzu.us>, 'Joe Perches' <joe@perches.com>,
 "'open list:LINUX FOR POWER M...'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, May 30, 2014 7:11 PM, Andrzej Hajda wrote:
> 
> This patchset makes get_brightness callback optional
> and removes trivial implementations.
> Driver changes are quite obvious so I have put them into single
> patch.
> 
> The patchset is based on the current linux-next branch.
> 
> Regards
> Andrzej
> 
> Andrzej Hajda (2):
>   backlight: show brightness even if get_brightness is not implemented
>   backlight: remove trivial get_brightness implementations

These patches look good!
Acked-by: Jingoo Han <jg1.han@samsung.com>

Lee Jones,
Would you merge these patches into backlight git?

Best regards,
Jingoo Han

> 
>  drivers/macintosh/via-pmu-backlight.c      | 6 ------
>  drivers/platform/x86/samsung-q10.c         | 6 ------
>  drivers/video/backlight/aat2870_bl.c       | 6 ------
>  drivers/video/backlight/ams369fg06.c       | 6 ------
>  drivers/video/backlight/backlight.c        | 2 ++
>  drivers/video/backlight/bd6107.c           | 6 ------
>  drivers/video/backlight/gpio_backlight.c   | 6 ------
>  drivers/video/backlight/ld9040.c           | 6 ------
>  drivers/video/backlight/lp855x_bl.c        | 6 ------
>  drivers/video/backlight/lp8788_bl.c        | 6 ------
>  drivers/video/backlight/lv5207lp.c         | 6 ------
>  drivers/video/backlight/pandora_bl.c       | 6 ------
>  drivers/video/backlight/pwm_bl.c           | 6 ------
>  drivers/video/backlight/s6e63m0.c          | 6 ------
>  drivers/video/backlight/tps65217_bl.c      | 6 ------
>  drivers/video/fbdev/aty/aty128fb.c         | 6 ------
>  drivers/video/fbdev/aty/atyfb_base.c       | 6 ------
>  drivers/video/fbdev/aty/radeon_backlight.c | 6 ------
>  drivers/video/fbdev/exynos/s6e8ax0.c       | 6 ------
>  drivers/video/fbdev/nvidia/nv_backlight.c  | 6 ------
>  drivers/video/fbdev/riva/fbdev.c           | 6 ------
>  21 files changed, 2 insertions(+), 120 deletions(-)
> 
> --
> 1.9.1
