Message-ID: <387142DF.7A3025D0@ctam.com.au>
Date: Tue, 04 Jan 2000 11:46:23 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>
CC: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cannot booting the kernel...
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn> <386ADE53.D3411F6A@ctam.com.au> <38704D0B.94438516@huawei.com.cn> <386AFFC5.E0134DB8@ctam.com.au> <38708C86.2CD58E66@huawei.com.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

> Hello,
>
>       With your help, Now I can starting my kernel.  I search linux-ppc lists and find
> that I have similar problems as you. Here is the messages:
>
>         Linux/PPC load:
>         Uncompressing Linux...done.
>         Now booting the kernel
>
> Then nothing happens. I also follow some suggestions which Dan advise you and modify
> arch/ppc/kernel/head.S to disable and unlock and invalidate the cache, but it seems to
> make no difference. Can you give me some advice ?

I disabled the caches in arch/ppc/kernel/head.S and arch/ppc/mbxboot/head.S.  The kernel
boots every time now (touch wood).

When my linux system is fully functioning (telnet, snmp, etc) then I will look at the
cache problems.  The gurus think that it is probably a UPM setup problem.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
