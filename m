Message-ID: <9ef20ef304072907243f820e04@mail.gmail.com>
Date: Thu, 29 Jul 2004 11:24:35 -0300
From: Gustavo Barbieri <barbieri@gmail.com>
To: Sven Luther <sven.luther@wanadoo.fr>,
	debian-kernel@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: rs/6000 e30 + 240 (doral) support
In-Reply-To: <20040729141631.GA20149@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <9ef20ef304071613494a0f0af9@mail.gmail.com> <20040717014441.GA13447@pegasos> <20040729135130.GE19197@lst.de> <9ef20ef3040729070439f6d8c1@mail.gmail.com> <20040729141631.GA20149@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Jul 2004 16:16:31 +0200, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jul 29, 2004 at 11:04:48AM -0300, Gustavo Barbieri wrote:
> > > Most doesn't look too bad to me, but it's a lot of patches.  I vaguely
> > > remember they were discussed on linuxppc-dev, so we should check the
> > > comments over there.
> >
> > A lot of patches? Well, there is a lot of "code"... it's not really
> > code, but just structure definitions... actually the patche touches
> > the real code at few points, one it's just a null pointer checking,
> > other are added cases to the switch statement so it can handle those
> > boards, so I really can't a problem there.
> >
> > I already sent an email to linuxppc-dev in the past, but no replies:
> >
> > http://lists.linuxppc.org/linuxppc-dev/200407/msg00085.html
>
> Ah sorry, I confused it with Len's big IBM prep patchkit.  Except for a
> tiny style issue this patch is fine with me.

What style issue?


> Any upstream comments as I'd hate to carry along a patch like that in
> the Debian patchkit while we'd probably want it in Sarge.
>
> Gustavo, if we apply this patch you'll have to sign up for d-i testing
> on prep, though ;-)

Ok, I test... actually I'm using sarge on that machine.

But I need to test it soon, as this machine may go away in few weeks.

--
Gustavo Sverzut Barbieri
---------------------------------------
Computer Engineer 2001 - UNICAMP
GPSL - Grupo Pro Software Livre
Cell..: +55 (19) 9165 8010
Jabber: gsbarbieri@jabber.org
  ICQ#: 17249123
   GPG: 0xB640E1A2 @ wwwkeys.pgp.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
