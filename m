Message-ID: <3E52F468.5020609@xopnetworks.com>
Date: Tue, 18 Feb 2003 21:05:12 -0600
From: Srini Amble <samble@xopnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel booting
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear All,

I have an  MPC 850 board with PPCBoot on it. The console is on SMC2 and
is set for 9600 baud. I have built the kernel using ELDK 2.0.2. make
mrproper,  make xconfig, make dep, and followed by make pImage were the
sequence of commands I used for generating the kernel. I have modified
some of the files in "include/asm-ppc" and "arch/ppc" directories to
account for board specificity. Using TFTP I download the kernel to the
target from my host. When I issue "bootm" command the boot loader
decompresses the kernel image and loads it into SDRAM. I see the message
"...Control is being turned over to Kernel..." and after that there is
no activity on the console. Would any kind soul have any suggestions as
to how I can proceed to debug the problem?

Thanks for all your help

Srini

P.S. If someone can list all the files that need to be modified to
account for a non-supported board then it will be much appreciated.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
