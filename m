Message-ID: <3A6F2AAB.71633047@wvi.com>
Date: Wed, 24 Jan 2001 11:19:07 -0800
From: Jim Potter <jrp@wvi.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mm in user space
References: <3A6CE6D4.83AD3800@wvi.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
