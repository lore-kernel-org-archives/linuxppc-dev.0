Message-ID: <387E02BC.DCCA86B0@apus.co.at>
Date: Thu, 13 Jan 2000 17:52:12 +0100
From: "Reni Pachernegg" <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: kd@flaga.is, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Building Glibc
References: <20000112225539.62B021B152@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
Troubles dont stop.
Started to build a new version of the GCC for Cross-Compiling for
PowerPc on i686. 
I found an installation-guide for gcc cross-compiler at
www.objsw.com/CrossGCC/FAQ-4.htm and followed the steps in 4.1.
(automate build script (4.5)didnt work). Using:
binutils 2.9.5.0.22
gcc 2.95.2
newlib-1.8.2
Installing the binutils was successfull.
Building gcc stopped with:
as: unknown option -ppc
Used script: 
target=powerpc-eabi
prefix=/bar
i=$prefix/bin
../gcc-2.8.1/configure --target=$target --prefix=$prefix -v /
--with-newlib --enable-languages=c --with-gnu-ld --with-gnu-as
make all install/
        AS_FOR_TARGET=$i/${target}-as \ 
        LD_FOR_TARGET=$i/${target}-ld \ 
        AR_FOR_TARGET=$i/${target}-ar \ 
        RANLIB_FOR_TARGET=$i/${target}-ranlib
The Assembler used, is the one installed by binutils for powerpc.
I didnt found any hint of any option -ppc in any file (greped it) in any
of the 3 tools. But there is the as option -mppc. Maybe this is the
option that is intended to be used.
Any propositions?
Regards 
	Rene

Does somebody know what to do??

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
