Date: Wed, 29 Oct 2003 06:56:34 -0800
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: mount root on the ml300 board
In-reply-to: <000701c39911$53d15f70$4844900a@hydingnb1>
To: hyding <nari_dhy@nari-china.com>
Cc: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F9FD522.5050106@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <000701c39911$53d15f70$4844900a@hydingnb1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Make sure to enable device file system (/devfs) support during kernel
configuration.

- Peter

hyding wrote:

>hi,
>    I am debugging MontaVista linux pro3.0(kernel 2.4.28) on the ml300
>board. I use IBM MicroDrive 1GB card to configure the FPGA and act as
>root fs. But the boot stops and displays the following:
>...
>block: 128 slots per queue, batch=32
>Partition check:
> xsysacea: xsysacea1 xsysacea2 xsysacea3
>System ACE at 0xCF000000 mapped to 0xC900F000, irq=9, 1052352KB
>Kernel panic: I have no root and I want to scream
> <0>Rebooting in 180 seconds..
>    There are 3 partitions in the CF card. The 1st is the fat12. The 2st
>is swap and the 3rd is the root. Kernel command line: console=ttyS0,9600
>root=/dev/sysace3 rw
>    Did someone have the problem? Any hints will be appreciable.
>
>Thanks!
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
