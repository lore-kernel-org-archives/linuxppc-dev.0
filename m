Message-Id: <5.0.0.19.2.20000926145616.01dd23e0@mail.munich.netsurf.de>
Date: Tue, 26 Sep 2000 15:01:38 +0200
To: Michel Dänzer <daenzerm@student.ethz.ch>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Linux keycodes and left cursor on Pismo
Cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39CFB72A.8974F2DB@student.ethz.ch>
References: <Pine.SOL.4.10.10009221556010.17778-100000@ncal.verio.com>
 <39CE9B1F.84530732@student.ethz.ch>
 <39CEF070.1A60BE5B@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 22:35 25.09.00, Michel Dänzer wrote:

>Martin Costabel wrote:
>
> > > > >After switching to Linux keycodes (and Debian's i386 us keymap), the
> > > > >left cursor key doesn't generate a keycode anymore. Interestingly, it
> > > > >works in X with Xkb, but not without.
> > > > >
> > > > >Anyone else sees this?
> > > >
> > > > Check the dev and user archives, I think this has been discussed a
> > > > few times since the new input layer backport went in.
> > >
> > > I've searched the archives now with no luck.
> >
> > I haven't seen this discussed, but I'll try a wild guess: What's
> > suspicious is that the linux keycode for KEY_LEFT is 105=0x69, the same
> > as the old mac keycode for SYSRQ_KEY. You could easily verify this by
> > pressing LEFT plus s or t or something and see whether it does some
> > emergency sync or whatever. Just a guess.
>
>But a good one! That's exactly the issue. I wonder how it has worked with Xkb
>in X though...
>
>As Magic Sysrq seems to always use ADB keycodes anyway, I'll not use it for
>now.

Sorry for not jumping in yet, but I had to concentrate on some time
consuming gcc-2.96 and glibc-2.2 issues to get things going.

Do you have by any chance a CHRP machine? I haven't touched chrp_setup.c yet.
If not, what exact kernel are you using?

BTW, there will be a new xf4 RPMs available soon.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
