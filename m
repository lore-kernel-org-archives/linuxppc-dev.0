Reply-To: <manu@stapf.org>
From: "Emmanuel STAPF" <manu@stapf.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Error when linking
Date: Sat, 20 Oct 2001 00:03:44 -0700
Message-ID: <001701c15935$5b6acff0$f5732c0c@venice2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

When compiling a big system composed of about 1000 c files, I get a lot
of errors such as reproduced below. Is there a solution to this problem?

Thanks,
Manu

/usr/lib/crt1.o: In function `_start':
/usr/lib/crt1.o(.text+0x20): relocation truncated to fit: R_PPC_REL24
__libc_start_main@@GLIBC_2.0
/usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o: In
function `__do_global_dtors_aux':
/usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o(.text+
0x94): relocation truncated to fit: R_PPC_PLTREL24
__deregister_frame_info@@GLIBC_2.0
/usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o: In
function `frame_dummy':
/usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o(.text+
0x12c): relocation truncated to fit: R_PPC_PLTREL24
__register_frame_info@@GLIBC_2.0
C1/Cobj1.o: In function `Facss3c':
C1/Cobj1.o(.text+0x1480c): relocation truncated to fit: R_PPC_REL24
__sigsetjmp@@GLIBC_2.0
C2/Cobj2.o: In function `Fan1eqv':
C2/Cobj2.o(.text+0x23b78): relocation truncated to fit: R_PPC_REL24
__sigsetjmp@@GLIBC_2.0
C2/Cobj2.o: In function `Fan3cjq':
C2/Cobj2.o(.text+0x24968): relocation truncated to fit: R_PPC_REL24
__sigsetjmp@@GLIBC_2.0
C2/Cobj2.o: In function `Fan3_hc':
C2/Cobj2.o(.text+0x2519c): relocation truncated to fit: R_PPC_REL24
__sigsetjmp@@GLIBC_2.0
C5/Cobj5.o: In function `Fbbi2tl':
C5/Cobj5.o(.text+0x10638): relocation truncated to fit: R_PPC_REL24
calloc@@GLIBC_2.0
C5/Cobj5.o: In function `Fbbow77':
C5/Cobj5.o(.text+0x1074c): relocation truncated to fit: R_PPC_REL24
calloc@@GLIBC_2.0
C5/Cobj5.o: In function `Fbb883r':
C5/Cobj5.o(.text+0x10920): relocation truncated to fit: R_PPC_REL24
calloc@@GLIBC_2.0
C5/Cobj5.o: In function `Fbcj80c':
C5/Cobj5.o(.text+0x10a74): relocation truncated to fit: R_PPC_REL24
calloc@@GLIBC_2.0
C5/Cobj5.o: In function `Fbcwjs6':
C5/Cobj5.o(.text+0x10bd8): relocation truncated to fit: R_PPC_REL24
calloc@@GLIBC_2.0
.....


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
