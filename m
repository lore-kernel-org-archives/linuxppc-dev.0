MIME-Version: 1.0
Content-Type: text/plain
Subject: booting problem
Date: Thu, 17 Jul 2003 08:52:28 +0800
Message-ID: <7A7A7A38134E244784EDAC428C538AE92A5742@mail.ndsc.com.cn>
From: =?gb2312?B?09rmug==?= <yujing@ndsc.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm porting hardhat linux v2.1 on my motorola lopec mpc7410 board with a
zynx zx212 dual-port ethernet card on it.The problem is that the kernel
can't start up with the ethernet card on,while without it everything is
perfect.Since zx212 is compatible with 21143,I build the kernel with
the "tulip" option on.It should be no problem,but it happened. It halts
after "now booting the kernel".
Does anybody have the same problem?

Best Regard
Yu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
