Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1378831590-2349-1-git-send-email-murzin.v@gmail.com>
References: <1378831590-2349-1-git-send-email-murzin.v@gmail.com>
Date: Tue, 10 Sep 2013 18:56:33 +0200
Message-ID: <CAMuHMdWHHsOm8qREeVVPBxcqJoa85xfgd-9jzqCnMs=Z9yVFCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fbdev/ps3fb: fix section mismatch warning for
 ps3fb_probe
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vladimir Murzin <murzin.v@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Tue, Sep 10, 2013 at 6:46 PM, Vladimir Murzin <murzin.v@gmail.com> wrote:
> diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
> index dbfe2c1..b269abd 100644
> --- a/drivers/video/ps3fb.c
> +++ b/drivers/video/ps3fb.c
> @@ -952,7 +952,7 @@ static struct fb_ops ps3fb_ops = {
>         .fb_compat_ioctl = ps3fb_ioctl
>  };
>
> -static struct fb_fix_screeninfo ps3fb_fix __initdata = {
> +static struct fb_fix_screeninfo ps3fb_fix = {
>         .id =           DEVICE_NAME,
>         .type =         FB_TYPE_PACKED_PIXELS,
>         .visual =       FB_VISUAL_TRUECOLOR,

Fixed before by Geoff, but never applied:
http://marc.info/?l=linux-fbdev&m=136914132618389&w=3

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
