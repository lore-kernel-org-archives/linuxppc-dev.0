Message-ID: <39CD3AA3.366F8634@student.ethz.ch>
Date: Sun, 24 Sep 2000 01:20:03 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: R Shapiro <reshapiro@mediaone.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
References: <14796.42915.582391.766766@ipa.ne.mediaone.net>
	 <39CCC5AB.C1C2E8B2@student.ethz.ch> <14796.52485.753924.552345@ipa.ne.mediaone.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:
>
> Michel Dänzer writes:
>  > > Specifics: with the ati driver selected, xf throws away my mode def,
>  > > since it thinks (incorrectly) that there isn't enough vram,
>  >
>  > Does it probe the correct amount of VRAM? Do you use Option "UseFBDev" ?
>
> The xf probe says 2MB, but in fact I have 4MB.  The dmesg line says:
>
> atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 4M SGRAM, 14.31818
> MHz XTAL, 230 MHz PLL, 75 Mhz MCLK

Which looks good. I am confident that the xfree86-pmac rsync driver will probe
that correctly using fbdev.


> I tried both UseFBDev on and off.  It didn't seem to make any
> difference.  Btw, which is correct setting if I'm not using the fbdev
> driver?

I don't think any version of the ati driver will work without "UseFBDev" on
PPC yet, and you need atyfb for that.


>  > > and then quits since it can't find any valid modes. In both cases I'm
>  > > running 4.0.1 from Franz Sirl's linuxppc page.
>  >
>  > While we're at it, can you please send me the URL of those?
>
>  ftp://devel.linuxppc.org/users/fsirl/xf4/RPMS/

Thanks, I've forwarded this to the apus-user list.


> Speaking of configs, I have a Device entry and a Screen entry for each
> physical display but they're all sharing the same Monitor entry (all
> three physical monitors are identical).   It that likely to work?

Don't know, if it doesn't work, just duplicate the Sections and give them
different Identifiers.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
