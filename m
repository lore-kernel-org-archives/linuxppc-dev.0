Message-ID: <E1836A7F3557D311A14000805F9F36FC01518839@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Friedlander, Paul" <PaulFriedlander@Danfoss.com>,
	"Hihn, Jason" <JasonHihn@Danfoss.com>
Subject: i2c_algo_8xx_init compile problem
Date: Mon, 11 Feb 2002 22:47:19 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am trying to get the Simon Vogel i2c driver implemented on my
Embedded Planet MPC823e platform but the kernel compile dies as follows:

[root@W032339 linux-2.2.14]# make -s dep
Makefile:37: warning: overriding commands for target `fastdep'
/opt/hardhat/devkit/lsp/linuxplanet/linux-2.2.14/Rules.make:106: warning:
ignoring
old commands for target `fastdep'
[root@W032339 linux-2.2.14]# make -s zImage
drivers/i2c/i2c.a(i2c-core.o): In function `i2c_init_all':
i2c-core.o(.text.init+0xb4): undefined reference to `i2c_algo_8xx_init'
i2c-core.o(.text.init+0xb4): relocation truncated to fit: R_PPC_REL24
i2c_algo_8xx_init
i2c-core.o(.text.init+0xb8): undefined reference to `i2c_rpx_init'
i2c-core.o(.text.init+0xb8): relocation truncated to fit: R_PPC_REL24
i2c_rpx_init
make: *** [vmlinux] Error 1

I changed the Makefile for i2c-2.6.2 to use the EP direcories and
successfully
used menuconfig to select the MPC8xx CPM I2C interface & Embedded
Planet RPX Lite/Classic support options but still this specific driver
(i2c_algo_8xx_init) isn't compiled even after doing a make dep. The docs
don't inform me which dir this file should go and be compiled in. Any
suggestions?

Regards,
     Michael Pergola
     Software Engineer
     Baltimore, MD  21236     (410) 931-6778 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
