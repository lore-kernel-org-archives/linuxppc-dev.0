Date: Mon, 2 Feb 2004 17:08:36 +0100 (MET)
From: Jean-Jacques Levy <jean-jacques.levy@inria.fr>
Message-Id: <200402021608.RAA0000011663@beaune.inria.fr>
To: linuxppc-dev@lists.linuxppc.org
Cc: schmitz@opal.biophys.uni-duesseldorf.de
Subject: Re: m3mirror + 2.4.24
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >    m3mirror crt:1 lcd:1
> >
> > which no longer works properly. The command runs silently with no
>
> The kernel ioctls for m3mirror might have changed; recompile m3mirror
> against new kernel headers?

That's what I did. For instance,

  strace m3mirror crt:1 lcd:1

shows

  ioctl(3, 0x40044001, 0x7ffff98c)

I don't know it that's fine.

-JJ-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
