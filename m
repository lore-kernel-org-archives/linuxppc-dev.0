Subject: Re: Debug PowerPC application with GDB over network on a i386
To: raphael.bossek@solutions4linux.de (Raphael Bossek)
Date: Mon, 10 Jul 2000 12:57:56 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20000709150022.A1493@raphael.bossek.home> from "Raphael Bossek" at Jul 09, 2000 03:00:22 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000710025756.F235624C@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Raphael Bossek writes:
> is it possible to use a graphical GDB frontend, e.g. DDD, on a i386 and
> debug application running on the PowerPC hardware where gdb is running too.
> I'm not talking about debugging the kernel, only simple applications!
> I thing about using the LAN interface for both GDB's... Using someone
> such a environment successfully here ?!

Yes, you run gdbserver on the embedded system. It worked fine for me under
gdb-4.18. I haven't had the need to try it again under gdb-5.0. You can get
the precompiled gdbserver from:
    ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/gdbserver.tgz

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
