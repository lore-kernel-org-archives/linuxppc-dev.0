Date: Mon, 25 Feb 2002 15:43:57 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202252343.g1PNhvc02671@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


mmap doesn't fail, it works, but running the program causes the system
to fail. It is something deeper, in the virtual memory system, that is
causing the trouble.

mmap is always returning the same address, something like
c0017000
for example.

-Dave

>Did you ever check the address returned from the mmap() call?  Is  it
>always the same, or in the same range, or does it actually look as if
>you were leaking mmap()ed memory even though you unmapped it?
>
>Which errno is returned when mmap() fails?
>
>
>
>Wolfgang Denk

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
