Date: Tue, 29 Jan 2002 19:26:56 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200201300326.g0U3Qu600178@dave.home>
To: val@nmt.edu
Subject: Re: BUG: udp socket, getsockopt + setsockopt
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I forgot to mention it doesn't act the same on my x86 desktop running
linux. I don't recall what version. On my pc there is no trouble.
Oh well.

Thanks--
Dave

>When you set SO_RCVBUF with setsockopt, the kernel allocates twice the
>memory you set.  This has something to do with BSD compatibility and
>storing internal kernel structures in the memory allocated for the
>recv buf.  Try getsockopt after you setsockopt.
>
>This is ostensibly a feature, not a bug.  Search the linux-kernel
>archives for "so_rcvbuf" and "David Miller".  Hint: you probably won't
>convince Dave to change his mind.
>
>-VAL

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
