Message-ID: <004b01bf3642$818e6ec0$73f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "LinuxPPC Developers List" <linuxppc-dev@lists.linuxppc.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Need help: shell for MPC860
Date: Wed, 24 Nov 1999 14:09:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,everyone

I built the kernel version 2.2.13 for a MPC860 board.
After the kernel boot and mount the RAMDISK as the root,
it begins to execute the /bin/sh, it catch a software emulation
exception. Is something wrong with the file linux/arch/ppc/kernel/softemu8xx.c?

Any suggestion?
Thanks in advanced.


Shuangjun


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
