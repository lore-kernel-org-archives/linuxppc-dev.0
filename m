Message-ID: <39CEF070.1A60BE5B@wanadoo.fr>
Date: Mon, 25 Sep 2000 08:28:00 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michel Dänzer <daenzerm@student.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux keycodes and left cursor on Pismo
References: <Pine.SOL.4.10.10009221556010.17778-100000@ncal.verio.com> <39CE9B1F.84530732@student.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Henry Worth wrote:
>
> > >After switching to Linux keycodes (and Debian's i386 us keymap), the left
> > >cursor key doesn't generate a keycode anymore. Interestingly, it works in
> > >X with Xkb, but not without.
> > >
> > >Anyone else sees this?
> >
> > Check the dev and user archives, I think this has been discussed a
> > few times since the new input layer backport went in.
>
> I've searched the archives now with no luck.

I haven't seen this discussed, but I'll try a wild guess: What's
suspicious is that the linux keycode for KEY_LEFT is 105=0x69, the same
as the old mac keycode for SYSRQ_KEY. You could easily verify this by
pressing LEFT plus s or t or something and see whether it does some
emergency sync or whatever. Just a guess.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
