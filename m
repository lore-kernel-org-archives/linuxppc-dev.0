Date: Thu, 5 Aug 2004 14:12:12 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: linux-2.6.8-rc3: invalid option ppc64bridge
Message-ID: <20040805121212.GA18525@macbeth.rhoen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
From: boris <boris@macbeth.rhoen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello ...

I cant compile 2.6.8-rc3 (2.6.8-rc2-bk13) because:

  make[1]: »arch/ppc/kernel/asm-offsets.s« ist bereits aktualisiert.
  CHK     include/linux/compile.h
  AS      usr/initramfs_data.o
  cc1: error: invalid option `ppc64bridge'
  make[1]: *** [usr/initramfs_data.o] Fehler 1

       mfg
                boris

PS: I use binutils 2.14.90.0.7-8, gcc-Version 3.3.4


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
