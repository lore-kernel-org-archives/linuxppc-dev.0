Return-Path: <lee.jones@linaro.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D21F71A035F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 23:32:47 +1000 (EST)
Received: by mail-ig0-f173.google.com with SMTP id r2so2910639igi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 06:32:44 -0700 (PDT)
Date: Mon, 16 Jun 2014 14:32:34 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 0/2] backlight: remove trivial get_brightness
 implementations
Message-ID: <20140616133234.GX14323@lee--X1>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
 <000701cf895e$6a648f20$3f2dad60$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <000701cf895e$6a648f20$3f2dad60$%han@samsung.com>
Cc: 'Milo Kim' <milo.kim@ti.com>,
 "'open list:FRAMEBUFFER LAYER'" <linux-fbdev@vger.kernel.org>,
 "'open list:X86 PLATFORM DRIVERS'" <platform-driver-x86@vger.kernel.org>,
 'Andrzej Hajda' <a.hajda@samsung.com>,
 'Thierry Reding' <thierry.reding@gmail.com>,
 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>,
 'Yijing Wang' <wangyijing@huawei.com>,
 'Matthew Garrett' <matthew.garrett@nebula.com>,
 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>,
 'Tomi Valkeinen' <tomi.valkeinen@ti.com>,
 'Geert Uytterhoeven' <geert@linux-m68k.org>,
 'Daniel Vetter' <daniel.vetter@ffwll.ch>,
 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>,
 'Dan Carpenter' <dan.carpenter@oracle.com>,
 "'open list:PWM SUBSYSTEM'" <linux-pwm@vger.kernel.org>,
 'Bryan Wu' <cooloney@gmail.com>,
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

On Mon, 16 Jun 2014, Jingoo Han wrote:

> On Friday, May 30, 2014 7:11 PM, Andrzej Hajda wrote:
> > 
> > This patchset makes get_brightness callback optional
> > and removes trivial implementations.
> > Driver changes are quite obvious so I have put them into single
> > patch.
> > 
> > The patchset is based on the current linux-next branch.
> > 
> > Regards
> > Andrzej
> > 
> > Andrzej Hajda (2):
> >   backlight: show brightness even if get_brightness is not implemented
> >   backlight: remove trivial get_brightness implementations
> 
> These patches look good!
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> Lee Jones,
> Would you merge these patches into backlight git?

Yep, done.

NB: You don't have to ask.  I'll see that you've reviewed/acked the
patches and just apply them automatically (provided I'm on the CC list
of course).

> >  drivers/macintosh/via-pmu-backlight.c      | 6 ------
> >  drivers/platform/x86/samsung-q10.c         | 6 ------
> >  drivers/video/backlight/aat2870_bl.c       | 6 ------
> >  drivers/video/backlight/ams369fg06.c       | 6 ------
> >  drivers/video/backlight/backlight.c        | 2 ++
> >  drivers/video/backlight/bd6107.c           | 6 ------
> >  drivers/video/backlight/gpio_backlight.c   | 6 ------
> >  drivers/video/backlight/ld9040.c           | 6 ------
> >  drivers/video/backlight/lp855x_bl.c        | 6 ------
> >  drivers/video/backlight/lp8788_bl.c        | 6 ------
> >  drivers/video/backlight/lv5207lp.c         | 6 ------
> >  drivers/video/backlight/pandora_bl.c       | 6 ------
> >  drivers/video/backlight/pwm_bl.c           | 6 ------
> >  drivers/video/backlight/s6e63m0.c          | 6 ------
> >  drivers/video/backlight/tps65217_bl.c      | 6 ------
> >  drivers/video/fbdev/aty/aty128fb.c         | 6 ------
> >  drivers/video/fbdev/aty/atyfb_base.c       | 6 ------
> >  drivers/video/fbdev/aty/radeon_backlight.c | 6 ------
> >  drivers/video/fbdev/exynos/s6e8ax0.c       | 6 ------
> >  drivers/video/fbdev/nvidia/nv_backlight.c  | 6 ------
> >  drivers/video/fbdev/riva/fbdev.c           | 6 ------
> >  21 files changed, 2 insertions(+), 120 deletions(-)
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
