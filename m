Date: Mon, 6 Aug 2001 01:16:18 +0200
From: Olaf Hering <olh@suse.de>
To: R Shapiro <reshapiro@mediaone.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
Message-ID: <20010806011618.A10728@suse.de>
References: <15213.15313.170106.433877@mediaone.net> <20010805200639.A14938@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010805200639.A14938@suse.de>; from olh@suse.de on Sun, Aug 05, 2001 at 08:06:39PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 05, Olaf Hering wrote:

>
> On Sun, Aug 05, R Shapiro wrote:
>
> >
> > When will the lcd17 kernel patches (needed to run linux on Apple's 17"
> > flat panel display) make it into penguinppc.org::linux-2.4-benh?  Or
> > are they there already? I'm running someone's prebuilt 2.4.2 with
> > those patches right now, since that seemed to be the only way to get
> > them.  But I'd really rather build my own kernel, with my preferred
> > .config and newer souces, if I can.
>
> Try this one in the meantime:
>
> diff -urN linux-2.4.7-orig/drivers/video/macmodes.c
> linux-2.4.7-pci/drivers/video/macmodes.c
> --- linux-2.4.7-orig/drivers/video/macmodes.c   Thu Jun 28 02:10:55 2001
> +++ linux-2.4.7-pci/drivers/video/macmodes.c    Sun Aug  5 20:03:16 2001
> @@ -68,7 +68,7 @@
>         0, FB_VMODE_NONINTERLACED
>      }, {
>         /* 1024x768, 60 Hz, Non-Interlaced (65.00 MHz dotclock) */
> -       "mac14", 60, 1024, 768, 15385, 144, 40, 29, 3, 136, 6,
> +        "mac14", 60, 1280, 1024, 15358, 160, 24, 29, 3, 136, 6,
>         0, FB_VMODE_NONINTERLACED
>      }, {
>         /* 1024x768, 72 Hz, Non-Interlaced (75.00 MHz dotclock) */

wrong timings:

9260 248 48 38 1 112 3
replace the 15358 .. with the stuff above.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
