Date: Fri, 22 Nov 2002 08:56:40 +0800
From: caixupeng <edmoon@huawei.com>
Subject: compile a linux kernel for ppc4xx, error message
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <001501c291c2$04745150$33690b0a@DBKQW41X>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I config the kernel as ppc4xx-->walnut ,a 405 based board. and make zImage,then
I got the following error messages:

{standard input}: Assembler messages:
{standard input}:44: Error: unsupported relocation against DCRN_EXISR
{standard input}:45: Error: unsupported relocation against DCRN_EXIER
{standard input}:72: Error: unsupported relocation against DCRN_EXIER
{standard input}:89: Error: unsupported relocation against DCRN_EXIER
{standard input}:106: Error: unsupported relocation against DCRN_EXIER
{standard input}:110: Error: unsupported relocation against DCRN_EXISR
{standard input}:25: Error: unsupported relocation against DCRN_EXIER
make[1]: *** [ppc4xx_pic.o] Error 1
make[1]: Leaving directory `/usr/src/src-linuxppc_2_4/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2


another question:

who has successed in compiling a linux kernel for ppc440GP?

I have made my ebony board run ppcboot correctly, and I want compile and download a

linux kernel to the ebony board.

who can help me?

thanks!

            edmoon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
