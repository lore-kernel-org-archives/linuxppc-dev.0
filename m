Date: Mon, 2 Feb 2004 17:58:14 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Jean-Jacques Levy <jean-jacques.levy@inria.fr>
Cc: linuxppc-dev@lists.linuxppc.org,
	<schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: m3mirror + 2.4.24
In-Reply-To: <200402021608.RAA0000011663@beaune.inria.fr>
Message-ID: <Pine.LNX.4.44.0402021755320.5301-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > >    m3mirror crt:1 lcd:1
> > >
> > > which no longer works properly. The command runs silently with no
> >
> > The kernel ioctls for m3mirror might have changed; recompile m3mirror
> > against new kernel headers?
>
> That's what I did. For instance,
>
>   strace m3mirror crt:1 lcd:1
>
> shows
>
>   ioctl(3, 0x40044001, 0x7ffff98c)
>
> I don't know it that's fine.

Me neither; I'd have to work out what the _IOW macro expands to in that
case. What kernel headers version do you have installed (f.i. Debian ships
2.5.999 which won't match your 2.4.24 kernel too well)?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
