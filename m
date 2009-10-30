Return-Path: <heyanandsu@gmail.com>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 8034EB7C34
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 20:35:33 +1100 (EST)
Received: by gxk23 with SMTP id 23so3222660gxk.2
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 02:35:31 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 30 Oct 2009 10:35:31 +0100
Message-ID: <231e15c10910300235y6b2332a6na587060f98814a3e@mail.gmail.com>
Subject: R_PPC_PLTREL24 reloc against local symbol
From: Pu Yiqiao <heyanandsu@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016362839e6c0cd3e047723bf9b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016362839e6c0cd3e047723bf9b
Content-Type: text/plain; charset=ISO-8859-1

Hi,
Now I am trying to work on ppc440. And when I compile my program I received
this error message while ld:
ppc_4xx-ld: fifo_tmp.o(.text+0x6158): R_PPC_PLTREL24 reloc against local
symbol
fifo_tmp.o: could not read symbols: Bad value
I am using ELDK 4.2.
and the compile flags is as following:
 /eldk4.2/ppc_4xx/usr/bin/../
cc1 -quiet -nostdinc -v -I/home/joy/work/ppc/partikle//user/ulibc/include
-imultilib m403/pic -iprefix
/eldk4.2/ppc_4xx/usr/bin/../lib/gcc/powerpc-linux/4.2.2/ -D__unix__
-D__gnu_linux__ -D__linux__ -Dunix -D__unix -Dlinux -D__linux -Asystem=linux
-Asystem=unix -Asystem=posix -Dxm_ppc440 fifo.c -quiet -dumpbase fifo.c
-mcpu=403 -auxbase-strip fifo.o -O2 -Wall -Wno-pointer-sign -version
-fexceptions -fno-builtin -fno-strict-aliasing -fPIC -fno-stack-protector
-fomit-frame-pointer -o /tmp/ccOIjGSh.s
 as -m403 -V -Qy -K PIC -o fifo.o /tmp/ccOIjGSh.s

Is there someone know why this is happend and how to resolve it?
Thank you.

-- 
Best wishes

                       Pu Yiqiao(Joy)

--0016362839e6c0cd3e047723bf9b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br>Now I am trying to work on ppc440. And when I compile my program I =
received this error message while ld:<br>ppc_4xx-ld: fifo_tmp.o(.text+0x615=
8): R_PPC_PLTREL24 reloc against local symbol<br>fifo_tmp.o: could not read=
 symbols: Bad value<br>
I am using ELDK 4.2. <br>and the compile flags is as following:<br>=A0/eldk=
4.2/ppc_4xx/usr/bin/../<div id=3D":59" class=3D"ii gt">cc1 -quiet -nostdinc=
 -v -I/home/joy/work/ppc/partikle//user/ulibc/include -imultilib m403/pic -=
iprefix /eldk4.2/ppc_4xx/usr/bin/../lib/gcc/powerpc-linux/4.2.2/
-D__unix__ -D__gnu_linux__ -D__linux__ -Dunix -D__unix -Dlinux
-D__linux -Asystem=3Dlinux -Asystem=3Dunix -Asystem=3Dposix -Dxm_ppc440
fifo.c -quiet -dumpbase fifo.c -mcpu=3D403 -auxbase-strip fifo.o -O2
-Wall -Wno-pointer-sign -version -fexceptions -fno-builtin
-fno-strict-aliasing -fPIC -fno-stack-protector -fomit-frame-pointer -o
/tmp/ccOIjGSh.s<br>=A0as -m403 -V -Qy -K PIC -o fifo.o /tmp/ccOIjGSh.s<br><=
br></div>Is there someone know why this is happend and how to resolve it?<b=
r>Thank you.<br clear=3D"all"><br>-- <br>Best wishes<br><br> =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pu Yiqiao(Joy)<br>
<br><br>

--0016362839e6c0cd3e047723bf9b--
