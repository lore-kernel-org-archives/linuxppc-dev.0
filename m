Message-Id: <38799BA3.269E8869@ict.ac.cn>
Date: Mon, 10 Jan 2000 16:43:15 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: problem with gunzip()
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

When I ported linux to a board with MPC860, 16M RAM and 2M Flash,
I met a problem.
After the program gunzip()(misc.c) the vmlinux image to address 0x0,
the contents from 0x0 to IMAGE_SIZE should be as same as that in
linux/vmlinux, right? I found that they are not same. Only from 0x0
to about 0xb500, they are same.
I don't think gunzip() has any problem.
Do you have any suggestions?
Thanks!

LiuTao

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
