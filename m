Return-Path: <mail4mz@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by ozlabs.org (Postfix) with ESMTP id 8FBA2DDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 09:00:35 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so2202525fke.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 15:00:33 -0700 (PDT)
Message-ID: <5c9cd53b0810201500j1c86dfffxdbfc6f5c5ab9728c@mail.gmail.com>
Date: Mon, 20 Oct 2008 15:00:33 -0700
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Kernel Oops when run ifconfig on MPC8360MDS board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

I have following kernel Oops when I run ifconfig to setup the UEC0 of
MPC8360MDS board. There is no hardware problem, the UEC0 runs well
under Uboot.

Any idea on this issue?

Thanks,

Mike


[root@localhost root]# ifconfig eth0 47.135.148.158
Oops: machine check, sig: 7
NIP: C0126910 XER: 20000000 LR: C01268D0 SP: CC10DD80 REGS: cc10dcd0
TRAP: 0200    Not tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cc10c000[349] 'ifconfig' Last syscall: 54
last math cc10c000 last altivec 00000000
GPR00: 00000000 CC10DD80 CC10C000 00000000 00001032 CC12D000 C0247264 C04D24C8
GPR08: BA2E8BA3 D1000010 C01EE55C 00000000 48022228 100235F8 00000000 00000000
GPR16: 00000000 00000000 10020000 10020000 00009032 CC10DE78 00000000 00000000
GPR24: FFFF8914 0000C000 C01D0000 CC10DDB8 D1000000 C0586E60 C0269C20 00000000
Call backtrace:
C0126890 C00D59D0 C00D761C C012F400 C0130DD4 C01746B4 C017712C
C0127770 C004D8B0 C0005ABC 00000000 10001214 100023C4 0FEC4E00
00000000
Bus error
