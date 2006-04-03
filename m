Return-Path: <sparking.lu@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id 90F7B679F7
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 21:39:48 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id k1so1589271nzf
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Apr 2006 04:39:46 -0700 (PDT)
Message-ID: <e9aafa30604030439y29b88638o220a4446295001d0@mail.gmail.com>
Date: Mon, 3 Apr 2006 19:39:46 +0800
From: "fengcheng lu" <sparking.lu@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Some issues of Linux2.6.16.1 compilation for MPC8548
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3571_16835982.1144064386734"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_3571_16835982.1144064386734
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all

     When I try to compile the latest kernel2.6.16.1 for MPC8548, I have th=
e
following questions.

     1. run the make command after the kernel is configured(all are default
configurations except the processor type is MPC8548), the following errors
are got
*         CC arch/powerpc/kernel/asm-offset.s*
*     In file included from include/asm-ppc/io.h:39*
*                           from include/asm/io.h:13,*
*                           from arch/powerpc/kernel/asm-offsets.c:33:*
*     arch/powerpc/include/asm/mpc85xx.h:29:40:
platforms/85xx/mpc8555_cds.h: No such file or directory*
*make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1*

  It seems the header file path is wrong. so I build the symbol link
         ln -s /usr/src/linux-2.6.16.1/include/platforms /usr/src/linux-
2.6.16.1/arch/ppc/platforms
         ln -s /usr/src/linux-2.6.16.1/include/syslib /usr/src/linux-
2.6.16.1/arch/ppc/syslib
  After that, the issues is fixed. But I have still other issues:

   2.
*     arch/powerpc/kernel/entry_32.S:48:24: head_booke.h: No such file or
directory*
*     make[1]: *** [arch/powerpc/kernel/entry_32.o] Error 1*
     I found this file in arch/ppc/kernel/head_booke.h and copy it into
arch/powerpc/kernel/ and re-compile it. sio this issue is fixed. but new
problem coming

   3.
*      ld: arch/powerpc/platforms/85xx/built-in.o: No such file: No such
file or directory*
*      make[1]: *** [arch/powerpc/platforms/built-in.o] Error 1*
**
*     What do I do? Any patches for these issues?*
**
**
*Best Regards*
*Lu *

------=_Part_3571_16835982.1144064386734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello all</div>
<div>&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; When&nbsp;I try to compile the latest kernel2=
.6.16.1 for MPC8548, I have the following questions.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; 1. run the make command after the kernel is c=
onfigured(all are default configurations except the processor type is MPC85=
48), the following errors are got</div>
<div><font style=3D"BACKGROUND-COLOR: #ffffff"><strong>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; CC arch/powerpc/kernel/asm-offset.s</strong></=
font></div>
<div><font style=3D"BACKGROUND-COLOR: #ffffff"><strong>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;In file included from include/asm-ppc/io.h:39</strong></font></di=
v>
<div><font style=3D"BACKGROUND-COLOR: #ffffff"><strong>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/=
asm/io.h:13,</strong></font></div>
<div><font style=3D"BACKGROUND-COLOR: #ffffff"><strong>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from arch/pow=
erpc/kernel/asm-offsets.c:33:</strong></font></div>
<div><font style=3D"BACKGROUND-COLOR: #ffffff"><strong>&nbsp;&nbsp;&nbsp;&n=
bsp; arch/powerpc/include/asm/mpc85xx.h:29:40: platforms/85xx/mpc8555_cds.h=
: No such file or directory</strong></font></div>
<div><font style=3D"BACKGROUND-COLOR: #ffffff"><strong>make[1]: *** [arch/p=
owerpc/kernel/asm-offsets.s] Error 1</strong></font></div>
<div><font style=3D"BACKGROUND-COLOR: #999999"></font>&nbsp;</div>
<div><font style=3D"BACKGROUND-COLOR: #ffffff">&nbsp; It seems the header f=
ile path is wrong. so I build the symbol link</font></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -s /usr/src/linux-=
<a href=3D"http://2.6.16.1/include/platforms">2.6.16.1/include/platforms</a=
> /usr/src/linux-<a href=3D"http://2.6.16.1/arch/ppc/platforms">2.6.16.1/ar=
ch/ppc/platforms</a></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -s /usr/src/linux-=
<a href=3D"http://2.6.16.1/include/syslib">2.6.16.1/include/syslib</a> /usr=
/src/linux-<a href=3D"http://2.6.16.1/arch/ppc/syslib">2.6.16.1/arch/ppc/sy=
slib</a></div>
<div>&nbsp; After that, the issues is fixed. But I have still other issues:=
</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; 2. </div>
<div><strong>&nbsp;&nbsp;&nbsp;&nbsp; arch/powerpc/kernel/entry_32.S:48:24:=
 head_booke.h: No such file or directory</strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffffff">&nbsp;&nbsp;&nbsp;&n=
bsp; make[1]: *** [arch/powerpc/kernel/entry_32.o] Error 1</font></strong><=
/div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I found this file in arch/ppc/kernel/head_boo=
ke.h and copy it into arch/powerpc/kernel/ and re-compile it. sio this issu=
e is fixed. but new problem coming</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; 3. </div>
<div><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ld: arch/powerpc/platforms/85xx=
/built-in.o: No such file: No such file or directory</strong></div>
<div><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make[1]: *** [arch/powerpc/plat=
forms/built-in.o] Error 1</strong></div>
<div><strong></strong>&nbsp;</div>
<div><strong>&nbsp;&nbsp;&nbsp;&nbsp; What do I do? Any patches for these i=
ssues?</strong></div>
<div><strong></strong>&nbsp;</div>
<div><strong></strong>&nbsp;</div>
<div><strong>Best Regards</strong></div>
<div><strong>Lu </strong></div>

------=_Part_3571_16835982.1144064386734--
