Date: Wed, 13 Dec 2000 12:12:31 -0800
From: Hao Li <hli@wag.caltech.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: vxhack and mvista kernel
Message-ID: <20001213121231.A26159@onetta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi. I am trying to use VxWorks boot rom to boot MontaVista's 2.4.0-test2
kernel on a EST SBC8260 board. I already have MontaVista's CDK 1.2
installed on a Linux x86 host running Red Hat 6.2. From a previous post
I find that I'll need to hack the kernel zImage with Dan Malek's
vxhack.c program. So below is what I did:

% uname -mrs
Linux 2.4.0-test11 i686
% cc --version
2.95.2
% ncftpget ftp://ftp.mvista.com/pub/Area51/ppc-8xx/vxhack.c
vxhack.c:                                                3.49 kB   29.64 kB/s
% cc -o vxhack vxhack.c
% cp /opt/hardhat/devkit/ppc/82xx/target/boot/vmlinuz-sbc8260-2.4.0-test2-1.2.2-3 .
% ./vxhack vmlinuz-sbc8260-2.4.0-test2-1.2.2-3
Segmentation fault


Could someone explain to me what the problem is? Is it because I do it
on a non-ppc host or I should not have used MontaVista's
vmlinuz-sbc8260-2.4.0-test2-1.2.2-3 kernel?

Thanks a lot!

- Hao


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
