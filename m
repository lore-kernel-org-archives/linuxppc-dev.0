Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <313680C9A886D511A06000204840E1CF08F43063@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'crossgcc@sources.redhat.com'" <crossgcc@sources.redhat.com>,
	"'wd@denx.de'" <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: FYI: building u-boot image in cygwin environment fails
Date: Fri, 23 Jul 2004 08:29:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


apovolot@USPITLAD104868 ~/U-boot/u-boot-1.1.1
$ make  MPC8260ADS_config
Configuring for MPC8260ADS board...

apovolot@USPITLAD104868 ~/U-boot/u-boot-1.1.1
$ make all
...............
make[1]: Entering directory
`/cygdrive/d/Profiles/apovolot/U-boot/u-boot-1.1.1/t
ools'
gcc -Wall -pedantic -D__WIN32__ -I../include -I.. -DTEXT_BASE=0xfff00000
-DUSE_H
OSTCC -O -c -o img2srec.o img2srec.c
In file included from img2srec.c:60:
../include/elf.h:46: warning: redefinition of `uint8_t'
/usr/include/stdint.h:24: warning: `uint8_t' previously declared here
../include/elf.h:47: warning: redefinition of `uint16_t'
/usr/include/stdint.h:25: warning: `uint16_t' previously declared here
../include/elf.h:48: error: conflicting types for `uint32_t'
/usr/include/stdint.h:28: error: previous declaration of `uint32_t'
make[1]: *** [img2srec.o] Error 1
make[1]: Leaving directory
`/cygdrive/d/Profiles/apovolot/U-boot/u-boot-1.1.1/to
ols'
make: *** [tools] Error 2

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
