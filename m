Message-ID: <3A79E135.6B45A9C8@matrox.com>
Date: Thu, 01 Feb 2001 17:20:37 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, Jim Potter <jrp@wvi.com>
Subject: Re: mm in user space
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I got exactly the same problem, did you manage to fix it?  If so, could
you tell me how ?  I really don't see it right now.  Maybe it's time to
go home...

Thanks!

Sébastien Côté



Jim Potter wrote :

DOH!  It's *supposed* to be taking a DSI trap (slapping forehead).

> I think I'm missing something here...
> I'm porting Linux over to an embedded PPC project and I'm getting a DSI
> crash when the kernel starts executing elf programs (specifically at
> NEW_AUX_ENT in create_elf_tables() in fs/binfmt_elf.c; the stack
> accesses are at 0x80000000, and the BATs are only expecting references
> at 0xC0000000).
> It's been a long day -- what am I missing?
>
> --
> Sincerely,
>
> Jim Potter
> 45th Parallel Processing
> jrp@wvi.com
>

--
Sincerely,

Jim Potter
45th Parallel Processing
jrp@wvi.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
