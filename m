Message-ID: <39B7AFC7.19AF37A1@student.ethz.ch>
Date: Thu, 07 Sep 2000 17:09:59 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
Subject: Re: newer xfree86 4.0.1 patches
References: <20000906213248.A3749@suse.de>
	 <5.0.0.19.2.20000907142215.01e79ca0@mail.munich.netsurf.de> <5.0.0.19.2.20000907164805.01f19660@mail.munich.netsurf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> > > On my TODO list, I still have to make chrp_setup.c and prep_setup.c use
> > > machid_init_hw() and friends in machid.c.
> >
> >While you're at it, can you do apus_setup.c as well please?
>
> Sure I can, but APUS doesn't use either ADB or PS2 keyboards, or?

No.


> I'm not quite sure about the following:
>
> - does Apus have it's own keycodes?

Yes, I think so. At least we need our own keymaps.

> If not, do you currently use ADB or AT keycodes?
> - what's the keycode situation in XF3/4 for Apus?

AFAIK it isn't very clean with either, the best bet is still to disable Xkb.


> - if your developer repository for 2.4 is different from BK linuxppc_2_3,
> did you integrate your input layer drivers in your trees and plan to submit
> them for 2.4?

We have a CVS repository at SourceForge. Roman Zippel integrates bitkeeper
into it, but unfortunately we don't have anyone for the reverse direction. How
could that be done?


> If you want to keep the current state of affairs I can see in the
> linuxppc_2_3 tree, there's not much point in using machid.c, AFAICS. On the
> other hand, if you plan to integrate your input drivers into 2.4, it makes
> perfect sense.

I think it would be nice, but to be honest I don't fully understand what would
be involved.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
