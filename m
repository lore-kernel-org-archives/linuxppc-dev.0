From: Thomas H?henleitner <th@visuelle-maschinen.de>
Reply-To: th@visuelle-maschinen.de
To: Adrian Cox <apc@agelectronics.co.uk>, th@visuelle-maschinen.de
Subject: Re: CTFB 0.30 now availiable (CT65554...CT69000)
Date: Mon, 19 Jun 2000 19:31:06 +0200
Content-Type: text/plain
Cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.05.10006161312290.5039-100000@callisto.of.borg> <00061912275000.10856@iris> <394DFFEF.162E7785@agelectronics.co.uk>
In-Reply-To: <394DFFEF.162E7785@agelectronics.co.uk>
MIME-Version: 1.0
Message-Id: <00061919325606.10856@iris>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mon, 19 Jun 2000 schrieb Adrian Cox:
> Thomas Hhenleitner wrote:
> >
> > The driver works now quite well with my hw.
> >
> > Check the ctfb_README for limits and features.
> >
> > What about a merge with the old chipsfb.o?
>
> I'm working on my 69030 driver as a separate driver currently, because
> of the requirement to use memory mapped IO and avoid all fixed IO
> addresses, which makes it incompatible with the 65550. I did look at
> your driver, but I decided to base mine on the existing chipsfb.c
> because I needed PowerPC support, and because the coding style of your
> driver was quite different to existing frame buffer drivers.
>
> My priorities are:
> 1) Not assume any BIOS setup, as BIOS setup only occurs on x86 hosts,
> and only on the primary display.
> 2) Avoid use of the big-endian region in the chip, while still
> supporting big-endian hosts. This is necessary to support the
> twin-pipeline mode of the 69030 in future.
> 3) Support multiple displays. This requires use of memory mapping.
>
> - Adrian Cox, AG Electronics

Where can I get the source of your driver to have a look at it?
Is the CT69030 availiable? The last I heard about it was, that it was cacelled.

Thomas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
