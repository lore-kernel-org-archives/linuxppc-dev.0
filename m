Message-ID: <3ADDB044.46E48FF8@iiic.ethz.ch>
Date: Wed, 18 Apr 2001 17:18:28 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	martin costabel <costabel@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010418131708.CDFE02EFC5@apollo.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> >>Ben just mailed me a much better suggestion:
> >>
> >>"Pass the SysRq combination in as a kernel argument".
> >>
> >>This would allow those with SysRQ keys (e.g. ISO/ANSI kbds) to use it,
> >>power books could have something that actually exists etc. etc.
> > [...]
> >
> > Very nice idea.
> >
> > ...hopefully defaulted to the standard Alt-f13/printscreen/sysrq-key in
> > the absense of the kernel commandline.
>
> what about defaulting to <cntl>-<power> if CONFIG_POWERBOOK is set on the
> kernel build?
> - the power key is not too far from cntl on newer PowerBook keyboards -
> anyone know about older ones?

Shouldn't really matter as ctrl is close to the keys used for Sysrq. ;)


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
