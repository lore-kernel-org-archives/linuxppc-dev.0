Message-ID: <001301bfbaf8$f678c970$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Help about the libc-2.1.1 segmentation fault
Date: Thu, 11 May 2000 11:28:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, everyone

On a MPC823 FADS board, I run the mpc8xx-2.2.13 kernel.
With the libc-2.1.1.so or libc-2.1.3.so, every application happened
    "Segmentation fault"
But if I compile the "hello world" program with  statically
linked library, or if I use the libc-1.99.so, there is no error.
Can I upgrade the libc to 2.x.x?

BTW, I have patched the linux kernel 2.3.33 FPU emulation patch.

So, what's wrong?

Thanks in advanced!

BRs,
Shuangjun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
