Message-ID: <39135108.89AF7D74@mac.com>
Date: Fri, 05 May 2000 18:54:07 -0400
From: Andy <lordpixel@mac.com>
Reply-To: lordpixel@mac.com
MIME-Version: 1.0
To: Florent <flobo@iname.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Re : 5 button mouse and XFree86 vers 4
References: <20000504224403.5E5A528E66@postfix1.free.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Florent wrote:
>
> ----------
> >Andrew Thompson <lordpixel@mac.com> wrote:
>
> > What I'm trying to do now is get all 5 buttons working on my
> > Kensington Mouseworks USB mouse.
>
> 3 buttons and 2 for the wheel ?

Nope 4 real buttons, and the wheel itself is a clickable button too...


> > I tried adding this lines to my XF86Config
> >         Option      "Buttons" "5"
> >
> > But no dice. Has anytone had any luck with > 3 buttons so far?
>
> Yes, I am using a Logitech USB wheel mouse and it works great with a few
> softwares (especially gtk-based ones)
>
> > Can someone enlighten me as to the story with USB mice on linux ppc? Are we
> > somehow shimying them so they appear as PS/2 or ADB?
> > Why isn't USB support on in the above RPMs? If I get the source RPM and
> > build it myself can I turn in on maybe?
>
> Since kernel 2.2.10 (if i remember), the USB mouse driver tries to emulate
> an IMPS/2 mouse (PS/2 Microsoft intellimouse), that is, 3 buttons and a
> wheel. So there is no need for softwares to support anything else than
> IMPS/2 to make use of your USB mouse.

Sigh. I was afraid of that. Yet the XFree86 version 4 specifically
mentions direct support for USB and for choosing "USB" as your protocol...
yet when I try this in the version I got from the RPM this protocol is unknown.

Unfortunately since I have > 3 real buttons it looks like I do need more
than generic IMPS/2 support.

Maybe I'll tru building XFree86 from source and see what happens...

AndyT

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
