From: iweiny@pacbell.net
Date: Thu, 25 Jan 2001 12:24:52 -0800 (PST)
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
In-reply-to: <200101251810.f0PIAeH04079@ashley.ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Message-id: <200101252024.MAA01557@batcave2.batcave>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if this helps or not but,
I get similar results from my 2 machines.

Machine 1 (2.2.18 glibc 2.1.3-4e)

12:17pm >./a.out
SIGUSR1 = 10
scp = 7ffff694
scp->signal = 0

Machine 2 (2.4.1 glibc 2.1.3-4e)  <= very recent BK kernel

11:21am >./a.out
SIGUSR1 = 10
scp = 7ffff634
scp->signal = 0

Ira

--- To quote Kevin B. Hendricks: ---
>
>
> Hi,
>
> Here is what I get from running it on my system (ppc linux with 2.2.15 kernel with some mods and glibc-2.1.3).
>
> But no segfault.
>
> Kevin
>
>
> [kbhend@localhost ~]$ gcc -O2 -ojunk junk.c
> [kbhend@localhost ~]$ ./junk
> SIGUSR1 = 10
> scp = 7fffe9a4
> scp->signal = 0
> [kbhend@localhost ~]$
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
