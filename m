Message-ID: <20020307070148.89600.qmail@web12803.mail.yahoo.com>
Date: Wed, 6 Mar 2002 23:01:48 -0800 (PST)
From: satya kumar <i_satya@yahoo.com>
Subject: Undefined refence error
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hai All,
My First mail to this group.Not a master , only a
newbie ,so please bear with me.
I have successfully compiled the binutils, gcc for
powerpc. Now I went for compiling glibc, which is
giving some problems, so I left it and proceeded with
compiling the kernel.
Now it is giving following error message when I do
make zImage
mm/mm.o: In function `__free_pages_ok':
mm/mm.o(.text+0xdee4): undefined reference to
`__test_and_change_bit'
mm/mm.o(.text+0xdee4): relocation truncated to fit:
R_PPC_REL24 __test_and_change_bit
mm/mm.o: In function `rmqueue':
mm/mm.o(.text+0xe0f8): undefined reference to
`__change_bit'
mm/mm.o(.text+0xe0f8): relocation truncated to fit:
R_PPC_REL24 __change_bit
mm/mm.o(.text+0xe190): undefined reference to
`__change_bit'
mm/mm.o(.text+0xe190): relocation truncated to fit:
R_PPC_REL24 __change_bit
make: *** [vmlinux] Error 1


Please help me out.I am stuck. I am compiling it for a
MPC860 board. I have selected the machine type as MBX
during configuring/compiling kernel( Is it right).


Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
