Message-ID: <313680C9A886D511A06000204840E1CF08F43047@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Dan Kegel'" <dank@kegel.com>,
	"'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
	"'bertrand marquis'" <bertrand_marquis@yahoo.fr>
Cc: crossgcc <crossgcc@sources.redhat.com>,
	"'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: missing elf.h (for mk_elfconfig.c)  while  building zImage for PP
	C on Intel platform (windows XP) using cygwin
Date: Wed, 21 Jul 2004 07:28:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have made changes in linux-2.6/scripts/kconfig/Makefile as advised and it
did fix menuconfig problem - thank you very much for being kind and patient
helping - much appreciated !

Now I am facing the next problem: missing elf.h (for mk_elfconfig.c) while
building zImage for PPC on Intel platform (windows XP) using cygwin.

>From where I could pick-up this include file ?

Thanks,
Alex
**********************
apovolot@USPITLAD104868 ~/linux-2.6.7
$ make zImage
  SPLIT   include/linux/autoconf.h -> include/config/*
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
scripts/mk_elfconfig.c:4:17: elf.h: No such file or directory


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
