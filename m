Message-ID: <38B6558D.A986E4AE@ict.ac.cn>
Date: Fri, 25 Feb 2000 18:12:29 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: The problem about MMU in MPC860
References: <38B4E19D.80A35E98@ict.ac.cn>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi:

This is really a boring problem, however, give me some
help please.
I am debugging the linux on my customized 860 board.
The linux can't bootup, the message in log_buf is:

Couldn't find 4096 bytes at 4096 alignment

When the program did map_page() in __ioremap(),
the problem happened.

Something wrong?
How to resolve it?
Any suggestion is welcome.

Thanks!

LiuTao

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
