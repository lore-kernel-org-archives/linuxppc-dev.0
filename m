Message-ID: <39B83F7C.EA7B41FF@student.ethz.ch>
Date: Fri, 08 Sep 2000 03:23:08 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
Subject: Re: newer xfree86 4.0.1 patches
References: <20000906213248.A3749@suse.de>
	 <5.0.0.19.2.20000907164805.01f19660@mail.munich.netsurf.de>
	 <39B7AFC7.19AF37A1@student.ethz.ch> <00090723415902.31531@enzo.bigblue.local>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> > > - what's the keycode situation in XF3/4 for Apus?
> >
> > AFAIK it isn't very clean with either, the best bet is still to disable
> > Xkb.
>
> On PPC we can switch the keycodes between ADB and Linux with a sysctl. Linux
> keycodes are ~95% compatible with AT keycodes, so XKB will work.

That would be great IMHO.


> > > - if your developer repository for 2.4 is different from BK
> > > linuxppc_2_3, did you integrate your input layer drivers in your trees
> > > and plan to submit them for 2.4?
> >
> > We have a CVS repository at SourceForge. Roman Zippel integrates bitkeeper
> > into it, but unfortunately we don't have anyone for the reverse direction.
> > How could that be done?
>
> Via Linus probably, but in this special case we could arrange something.

Please post to linux-apus-devel@lists.sourceforge.net what we'd have to do.


> > > If you want to keep the current state of affairs I can see in the
> > > linuxppc_2_3 tree, there's not much point in using machid.c, AFAICS. On
> > > the other hand, if you plan to integrate your input drivers into 2.4, it
> > > makes perfect sense.
> >
> > I think it would be nice, but to be honest I don't fully understand what
> > would be involved.
>
> Actually not much, given the Apus input drivers in the linuxconsole
> repository ("ruby") on sourceforge are already functional,

I don't know, so I assume not :(

> it's simply a matter of copying the files and modifying the configuration
> scripts. If you want to continue to support Apus keycodes, you need some
> translation code in input/keybdev.c too.

Thanks.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
