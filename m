Message-ID: <3B882749.346A0B39@iiic.ethz.ch>
Date: Sun, 26 Aug 2001 00:31:37 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	Keith Clayton <keith@claytons.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc 2.1 -> 2.2 gotchas?
References: <998751333.12597.3.camel@yoda> <01082511424509.15847@localhost.localdomain> <20010826005515.Postino-022357@smtp01.highway.ne.jp> <01082513443402.16172@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:

> > it's no needs.
> > Please read glibc's FAQ  which has glibc source
> >
> > I have here also at
> >
> >  ftp://ftp.linuxppc.org/users/kfukui/glibc-2.2.x-room/RPMS/FAQ.glibc-2.2.3
>
> All I saw here was for installing after building from source code.  I did
> not see anything about installing using a package manager.
>
> Perhaps my use of "ldconfig -v; sync; sync; shutdown -r now" comes from the
> days when rpm was not always staticaly linked with libc?

dpkg still isn't.

> What I recommend won't hurt and can certainly help flush older shared
> libraries out of memory.

The point is probably that in the Debian packages, the maintainer scripts take
care of the necessary steps, so the user doesn't have to.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
