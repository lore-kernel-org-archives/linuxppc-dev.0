Return-Path: <murzin.v@gmail.com>
Date: Tue, 10 Sep 2013 19:05:17 +0200
From: Vladimir Murzin <murzin.v@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] fbdev/ps3fb: fix section mismatch warning for
 ps3fb_probe
Message-ID: <20130910170508.GA2460@hp530>
References: <1378831590-2349-1-git-send-email-murzin.v@gmail.com>
 <CAMuHMdWHHsOm8qREeVVPBxcqJoa85xfgd-9jzqCnMs=Z9yVFCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <CAMuHMdWHHsOm8qREeVVPBxcqJoa85xfgd-9jzqCnMs=Z9yVFCw@mail.gmail.com>
Cc: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Geoff Levand <geoff@infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 10, 2013 at 06:56:33PM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 10, 2013 at 6:46 PM, Vladimir Murzin <murzin.v@gmail.com> wrote:
> > diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
> > index dbfe2c1..b269abd 100644
> > --- a/drivers/video/ps3fb.c
> > +++ b/drivers/video/ps3fb.c
> > @@ -952,7 +952,7 @@ static struct fb_ops ps3fb_ops = {
> >         .fb_compat_ioctl = ps3fb_ioctl
> >  };
> >
> > -static struct fb_fix_screeninfo ps3fb_fix __initdata = {
> > +static struct fb_fix_screeninfo ps3fb_fix = {
> >         .id =           DEVICE_NAME,
> >         .type =         FB_TYPE_PACKED_PIXELS,
> >         .visual =       FB_VISUAL_TRUECOLOR,
> 
> Fixed before by Geoff, but never applied:
> http://marc.info/?l=linux-fbdev&m=136914132618389&w=3

Great! Hope some day it will ;)

Sorry for the noise
Vladimir

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
