Message-ID: <006101c4184c$2c14fa90$14589edd@alpha>
From: "???" <shchoi@airpoint.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Quetions : insmod command error
Date: Fri, 2 Apr 2004 09:48:10 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a problem with module loading for kernel 2.6.3.

< environment >
1) target : ppc8260 custom board.
2) kernel has compiled with module support
3) using kernel 2.6.3
4) using modutils 2.4.22
5) include/config/modules.h had #define CONFIG_MODULES 1

< test message >
bash-2.05b# ls
Makefile  Makefile.l  hello.c  hello.ko  hello.mod.c  hello.mod.o  hello.o
bash-2.05b# insmod hello.ko
insmod: QM_MODULES: Function not implemented

bash-2.05b# depmod -V
depmod version 2.4.22
depmod: QM_MODULES: Function not implemented

and
I heard that mode-init-utils upgrade.
I got to "module-init-tools-3.0.tar.gz'
After install, the following error message

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46

stopped..

Any help would be appreciated.
Thanks,
call me "Lone"....
shchoi@airpoint.co.kr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
