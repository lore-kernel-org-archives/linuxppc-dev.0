From: Subodh Nijsure <subodh@best.com>
Message-Id: <200108282010.NAA29698@shell9.ba.best.com>
Subject: Unsupported relocation type err while compiling head_8xx.S
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 28 Aug 2001 13:10:05 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to compile linux kernel on of my development machine and
compiler is throwing up these errors while compiling head_8xx.S

ppc_8xx-gcc -D__ASSEMBLY__ -D__KERNEL__
-I/home/baijnath/subodh/NMR/BSP/SCM/linux/include
-c -o head_8xx.o head_8xx.S
head_8xx.S: Assembler messages:
head_8xx.S:227: Error: unsupported relocation type
head_8xx.S:227: Error: unsupported relocation type
...
...
..

However same kernel source code compiles fine on two other workstations,
I have exactly same copy of development toolkits ( cross-compilers,
headers etc. ) on other two workstations i.e. stuff in /opt/hardhat is
same on all four workstations and only one workstation is having this
problem....

Has anybody seen this error before and found a solution?
[ Its not like I haven't spend lot of time trying to figure out what
could be wrong, but all the things I have tried don't seem to fix this
problem, also have searched mailing list archive, deja

Yes I tried compiling things "by hand" and when I usee ppc_8xx-gcc -v the
compiler and assembler options all same on four machines, only one machine
doesn't like them. I am using HardHat 1.2 development kits.


ppc_8xx-gcc  -v
Reading specs from /opt/hardhat/devkit/ppc/8xx/lib/gcc-lib/powerpc-hardhat-linux/2.95.2/specs
gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)
ppc_8xx-as  -v
GNU assembler version 2.10.90 (powerpc-hardhat-linux) using BFD version 2.10.0.12


Any pointers...

/Subodh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
