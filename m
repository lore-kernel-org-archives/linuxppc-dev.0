Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6D17@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: Cross compiling glibc-2.2.3
Date: Tue, 16 Apr 2002 17:30:14 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am trying to crosscopile glibc-2.2.3 for the mpc8xx.

I use the folowing configure script, but when I do make it fails after a
while.

export AR=ppc_8xx-ar
export CC=ppc_8xx-gcc
export CFLAGS="-msoft-float -D_SOFT_FLOAT -mcpu=860"
export RANLIB=ppc_8xx-ranlib

./configure	--enable-kernel=2.4.4 --host=powerpc-linux
--build=i686-pc-linux-gnu \
		--with-headers=/usr/src/linux-2.4.4/include \
		--enable-add-ons=linuxthreads \
		--without-fp


Anybody has already crosscompiled glibc 2.2.3 for mpc8xx?

I know that for glibc-2.1.2 there is a patch in denx page, but for glibc
2.2.3 is there any patch?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
