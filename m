Message-ID: <38B4E19D.80A35E98@ict.ac.cn>
Date: Thu, 24 Feb 2000 15:45:33 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: The problem about MMU in MPC860
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

This is really a boring problem, however, give me some
help please.
I am debugging the linux on my customized 860 board.
The linux can't bootup, the message is:

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
loaded at:     00200000 0020B1D4
zimage at:     00230164 0028534F
avail ram:     00286000 00FFFFFF

I think that's the MMU's problem.
How to resolve it?
Any suggestion is welcome.

Thanks!

LiuTao

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
