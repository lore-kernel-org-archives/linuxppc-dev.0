Date: Wed, 23 Aug 2000 15:18:23 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Lanners <mlan@cpu.lu>
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4 hangs on 2.4 kernel (was: Re: Control fb problem on 8500)
In-Reply-To: <200008191415.QAA00716@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.21.0008231516001.19621-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 19 Aug 2000, Michel Lanners wrote:

>
> On  19 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
> >>My XFree 4.0 goes into an infinite loop eating CPU time when I boot a
> >>2.4.0 kernel. Xpmac does work, but with the artifact described in my
> >>previous mail.
> >
> > I have this exact same problem with XF4 on my Pismo (r128) with any 2.4.
> > The X server dies in this infinite loop and a black screen. Theo only way
> > I found to get the screen back is to telnet into the box, kill -9 the X
> > server, and launch Xpmac. This seems to restore the console system into a
> > working state.
>
> Ahh, so that problem is not control-specific.
>
> > I don't know what's up yet.
>
  I had the same problem, for me it went away after i disabled xfs
i didn't had any time yet to check whats going on (i am in vacations)
but i'll try to see whats wrong once i am back.

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
