Subject: re: pmc network card problem
MIME-Version: 1.0
Content-Type: text/plain
Date: Wed, 23 Jul 2003 11:28:09 +0800
Message-ID: <7A7A7A38134E244784EDAC428C538AE92A580D@mail.ndsc.com.cn>
From: =?gb2312?B?09rmug==?= <yujing@ndsc.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!
I got it.
There does something wrong with "pciauto_bus_scan". I delete it from
"lopec_find_bridges", then everything is ok!
But I still can't understand why this happened?
Could you help me?

----- Original Message -----
  I'm porting mvista linux2.1 on my motorola lopec mpc7410 board with a
zynx zx212 dual-port ethernet card on it.The problem is that the kernel
can't start up with the ethernet card on,while without it everything
is perfect.Since zx212 is compatible with 21143,I build the kernel
with the "tulip" option on.It should be no problem,but it happened.
It halts after "now booting the kernel". Zx212 is a PMC network card
with Intel 21143 and Intel PCI Bridge 21152. Through the bdi2000,
it seems that there are something wrong with "setup_arch",and maybe
"pciauto_bus_scan".But I'm not sure. Maybe you can help me.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
