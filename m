Message-Id: <387EAB4B.B9FFF19E@ict.ac.cn>
Date: Fri, 14 Jan 2000 12:51:23 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Do me a favor about gunzip()
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

If you have a board with MPC860 and you ported Linux to your board
successfully, do me a favor please.

Do following steps:
1. Use objdump to find out the location of identify_machine() in
vmlinux,
in my vmlinux, the location is 0xC00C8984.
2. Setup a break point after gunzip() in decompress_kernel().
3. Check the location(0x000C8984) of identify_machine(), is the
contents correct?

By the way, what kind of debug tool are you using when you port and
debug Linux on your PowerPC board?

Thanks!

LiuTao

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
