Message-ID: <3DE3A052.DD7CABFB@midrivers.com>
Date: Tue, 26 Nov 2002 09:24:50 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: building walnut kernel, '_machine redefined' warning
References: <NEBBKJPFOLJNBMFNKBIIGELKDCAA.clh@net1plus.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


yesterday afternoon I cloned the bitkeeper tree,
did a make walnut_config,
make menuconfig
saved the configuration,
did a make dep
and make vmlinux

and get the following redefininition for _machine:

In file included from
/home/mpilon/linuxppc_2_4_devel_bk_405pm/include/linux/modversions.h:221,
                 from
/home/mpilon/linuxppc_2_4_devel_bk_405pm/include/linux/module.h:21,
                 from printk.c:26:
/home/mpilon/linuxppc_2_4_devel_bk_405pm/include/linux/modules/ppc_ksyms.ver:204:
warning: `_machine' redefined
/home/mpilon/linuxppc_2_4_devel_bk_405pm/include/asm/processor.h:801:
warning: this is the location of the previous definition


have I missed a step, is this broken or benign?

the rsync tree I pulled earlier doesn't display this behavior ...


Mark



--
Mark Pilon
Minolta-QMS

P.O. Box 37
325 Dawson County Road 227
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
