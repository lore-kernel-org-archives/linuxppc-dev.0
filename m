Message-ID: <38D9C04D.A1F6B259@email.sps.mot.com>
Date: Thu, 23 Mar 2000 07:57:17 +0100
From: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: no symbol-table - /proc-fs empty
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

i use a MBX860 which is connectet via NFS to its root filesystem. The
kernel i use is a 2.2.13 which has /proc filesystem enabled. After the
MBX-board is booted i have no access to the symbol table.
To be shure it's not a failure in my modul, i use the easiest one i
found (hello-modul from Alessandro Rubini). Below you can see what's
happend after the insmod command.

#insmod -v hello.o
Section 1: (.text) at 0x18537b8
Section 2: (.rela.text) at 0x1854e98
Section 3: (.data) at 0x1853830
Section 5: (.modinfo) at 0x1853830
Section 6: (.sdata) at 0x1853830
Section 7: (.rodata) at 0x1853838
Section 8: (.comment) at 0x1853868
Section 9: (.shstrtab) at 0x1854ee8
Section 10: (.symtab) at 0x1854f48
Section 11: (.strtab) at 0x18550a0
textseg = 0x18537b8
bss_size = 25507984
last byte = 0x1854890
module size = 4312
jump table = 0x1853890
versioned kernel: no
versioned module: no
ELF kernel
ELF module
printk undefined
Loading failed! The module symbols (from linux-2.2.13) don't match your
linux-2.2.13
#

Also the /proc directory is empty.
I have no idea and so i would be happy if anyone can tell me what's
going wrong.


------------------------
Stephan Ruettiger
Motorola Munich
r0337c@email.sps.mot.com
------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
