From: "Frank Smith" <smith@amirix.com>
To: "Raphael Bossek" <raphael.bossek@solutions4linux.de>,
        <linuxppc-embedded@lists.linuxppc.org>
Cc: <smith@amirix.com>
Subject: RE: Debug PowerPC application with GDB over network on a i386
Message-Id: <00Jul9.081146adt.7307@dragon.appliedmicro.ns.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20000709150022.A1493@raphael.bossek.home>
Date: Sun, 9 Jul 2000 08:11:43 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Raphael,

I've used DDD on an x86 host, talking over rsh to
a gdb running on the powerpc target.

It works, but sometimes the communication between the
host and the target isn't very responsive-- I think
there's probably buffereing issues involved.

To try it out, just read the DDD docs. I believe the
invocation of ddd is something like

ddd --host USER@TARGET BINARY


Frank.


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Raphael
> Bossek
> Sent: Sunday, July 09, 2000 7:57 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Debug PowerPC application with GDB over network on a i386
>
>
>
> hi all,
>
> is it possible to use a graphical GDB frontend, e.g. DDD, on a i386 and
> debug application running on the PowerPC hardware where gdb is
> running too.
> I'm not talking about debugging the kernel, only simple applications!
> I thing about using the LAN interface for both GDB's... Using someone
> such a environment successfully here ?!
>
> --
> Raphael Bossek <raphael.bossek@solutions4linux.de> [ICQ #40047651]
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
