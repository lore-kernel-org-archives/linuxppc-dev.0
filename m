Message-ID: <39B910DB.182D6E64@student.ethz.ch>
Date: Fri, 08 Sep 2000 18:16:27 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
Subject: Re: newer xfree86 4.0.1 patches
References: <20000906213248.A3749@suse.de>
	 <5.0.0.19.2.20000907164805.01f19660@mail.munich.netsurf.de>
	 <39B7AFC7.19AF37A1@student.ethz.ch> <00090723415902.31531@enzo.bigblue.local> <5.0.0.19.2.20000908155531.020f1200@mail.munich.netsurf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> > > > > - what's the keycode situation in XF3/4 for Apus?
> > > >
> > > > AFAIK it isn't very clean with either, the best bet is still to
> > > > disable Xkb.
> > >
> > > On PPC we can switch the keycodes between ADB and Linux with a sysctl.
> > > Linux keycodes are ~95% compatible with AT keycodes, so XKB will work.
> >
> >That would be great IMHO.
>
> And easy to do. See below.

Thanks for the detailed description. Unfortunately, I'm currently very busy
with exams, work, DRI, APUS, ..., but if I can get some time I'll look into
it. Or better, I encourage the other APUS developers to do so.

BTW you mentioned that somebody apparently already worked on the Amiga part of
the linuxconsole code - do you know who did it?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
