Date: Sat, 6 May 2000 17:14:59 -0500 (CDT)
From: ian reinhart geiser <geiseri@msoe.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems Compileing PVM
Message-ID: <Pine.LNX.4.10.10005061706360.6831-100000@sleepchamber.apt5.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,
	I have a problem with compileing PVMd
	on my LinuxPPC 1999 dist.

	When i try to build anything liked off of the
	PVM libs i get the following errors:

	../../lib/LINUXPPC/libpvm3.a(lpvmpack.o): In function
`pvm_vpackf': lpvmpack.o(.text+0x53e8): undefined reference to
`__va_arg_type_violation'
	lpvmpack.o(.text+0x53e8): relocation truncated
to fit: R_PPC_REL24 __va_arg_type_violation
	lpvmpack.o(.text+0x54f4):
undefined reference to `__va_arg_type_violation'
	lpvmpack.o(.text+0x54f4): relocation truncated to fit: R_PPC_REL24
__va_arg_type_violation

	It looks like a linker error...
	i have never had this error before on any
	of my other systems(ARM, ALPHA and INTEL).

	has anyone seen this?  or am i looking in the
	wrong list?

	thanks
	-ian reinhart geiser

-------------------------------------------------
Ian Reinhart Geiser <geiseri@msoe.edu>
DEC Unix Systems Adimistrator and
	Computer Engineering Student
http://www.msoe.edu/~geiseri/finger.phtml


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
