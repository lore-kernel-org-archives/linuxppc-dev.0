Message-ID: <39111C96.B0B3E684@huawei.com.cn>
Date: Thu, 04 May 2000 14:45:42 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860 enet driver ...
References: <39104A07.D997B6C5@ccrl.mot.com> <3910838C.986942D6@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
        I want to write a bootloader which will do the following steps:
       1.  download the kernel via TFTP protocol onto RAM address 0x400000.
       2. go to 0x400000 and run the kernel.
 The receive()/send() is based on /usr/src/linux/arch/ppc/8xx_io/enet.c, using
polling mode instead of interrupt mode.
However , It can only download 96 packets(512bytes/packet,so
96*512/1024=48k)successfully. If the kernel file is larger than 48K, then it
will stop here when it downloads 48k. That is to say, it can only download
files which is smaller than 48K.
Maybe I should modify some parameters for MPC860 in enet.c?
How can I solve this?
 Thank you very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
