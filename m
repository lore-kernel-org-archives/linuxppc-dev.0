Message-ID: <38708C86.2CD58E66@huawei.com.cn>
Date: Mon, 03 Jan 2000 19:48:22 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Cannot booting the kernel...
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn> <386ADE53.D3411F6A@ctam.com.au> <38704D0B.94438516@huawei.com.cn> <386AFFC5.E0134DB8@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

      With your help, Now I can starting my kernel.  I search linux-ppc lists and find
that I have similar problems as you. Here is the messages:

        Linux/PPC load:
        Uncompressing Linux...done.
        Now booting the kernel

Then nothing happens. I also follow some suggestions which Dan advise you and modify
arch/ppc/kernel/head.S to disable and unlock and invalidate the cache, but it seems to
make no difference. Can you give me some advice ?
Thank you :-))
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
