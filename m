Return-Path: <john.d@servergy.com>
Received: from mail-oa0-f42.google.com (mail-oa0-f42.google.com
 [209.85.219.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 567F92C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:58:46 +1100 (EST)
Received: by mail-oa0-f42.google.com with SMTP id i4so35826oah.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 15:58:43 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 19 Mar 2014 17:58:42 -0500
Message-ID: <CAGtOQbTgXnxEHfuqtQ-BwpsnY=J2WktMFTNXysfYw9-cYprstQ@mail.gmail.com>
Subject: 3.16.6 build error: swsusp_booke.S:85: Error: invalid sprg number
From: John Donnelly <john.d@servergy.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=f46d044630a81ecbf004f4fd98fb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d044630a81ecbf004f4fd98fb
Content-Type: text/plain; charset=ISO-8859-1

Platform: Freescale  p4080--e500mc  ,

Suggestions welcome .

 /bin/sh arch/powerpc/kernel/systbl_chk.sh arch/powerpc/kernel/systbl_chk.i
make -f scripts/Makefile.build obj=arch/powerpc/kernel/vdso32
  gcc -mbig-endian -m32 -Wp,-MD,arch/powerpc/kernel/.swsusp_booke.o.d
 -nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.8.2/include
-I/root/linux-3.13.6/arch/powerpc/include -Iarch/powerpc/include/generated
 -Iinclude -I/root/linux-3.13.6/arch/powerpc/include/uapi
-Iarch/powerpc/include/generated/uapi -I/root/linux-3.13.6/include/uapi
-Iinclude/generated/uapi -include
/root/linux-3.13.6/include/linux/kconfig.h -D__KERNEL__ -Iarch/powerpc
 -D__ASSEMBLY__ -Iarch/powerpc  -gdwarf-2          -c -o
arch/powerpc/kernel/swsusp_booke.o arch/powerpc/kernel/swsusp_booke.S
arch/powerpc/kernel/swsusp_booke.S: Assembler messages:
arch/powerpc/kernel/swsusp_booke.S:85: Error: invalid sprg number
arch/powerpc/kernel/swsusp_booke.S:87: Error: invalid sprg number


-- 

*Regards,*
* John.*

*--*

*o* Energy-efficiency is #1 reason data centers look to expand.  -- Digital
Realty Trust
*o* Green Data Centers spending to increase 300% worldwide by 2016.  --
Pike Research
*o *Data Centers have become as vital to the functioni
ng of society as power stations.  -- The Economist

--f46d044630a81ecbf004f4fd98fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Platform: Freescale =A0p4080--e500mc =A0,</div><div><=
br></div><div>Suggestions welcome .=A0</div><div><br></div><div>=A0/bin/sh =
arch/powerpc/kernel/systbl_chk.sh arch/powerpc/kernel/systbl_chk.i</div><di=
v>make -f scripts/Makefile.build obj=3Darch/powerpc/kernel/vdso32</div>
<div>=A0 gcc -mbig-endian -m32 -Wp,-MD,arch/powerpc/kernel/.swsusp_booke.o.=
d =A0-nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.8.2/include -I/ro=
ot/linux-3.13.6/arch/powerpc/include -Iarch/powerpc/include/generated =A0-I=
include -I/root/linux-3.13.6/arch/powerpc/include/uapi -Iarch/powerpc/inclu=
de/generated/uapi -I/root/linux-3.13.6/include/uapi -Iinclude/generated/uap=
i -include /root/linux-3.13.6/include/linux/kconfig.h -D__KERNEL__ -Iarch/p=
owerpc =A0-D__ASSEMBLY__ -Iarch/powerpc =A0-gdwarf-2 =A0 =A0 =A0 =A0 =A0-c =
-o arch/powerpc/kernel/swsusp_booke.o arch/powerpc/kernel/swsusp_booke.S</d=
iv>
<div>arch/powerpc/kernel/swsusp_booke.S: Assembler messages:</div><div>arch=
/powerpc/kernel/swsusp_booke.S:85: Error: invalid sprg number</div><div>arc=
h/powerpc/kernel/swsusp_booke.S:87: Error: invalid sprg number</div><div>
<br></div><div><br></div>-- <br><div dir=3D"ltr"><div style=3D"font-family:=
Arial;font-size:12px"><span style=3D"border-collapse:collapse"><div style=
=3D"border-collapse:collapse"><div style=3D"margin:0px;display:inline!impor=
tant"><span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font col=
or=3D"#67b545"><b><br>
</b></font></span></div></div><div style=3D"border-collapse:collapse"><font=
 color=3D"#67b545"><b>Regards,</b></font></div><div style=3D"border-collaps=
e:collapse"><font color=3D"#67b545"><b>=A0John.</b></font></div><div style=
=3D"border-collapse:collapse">
<font color=3D"#67b545"><b><br></b></font></div><div style=3D"border-collap=
se:collapse"><div style=3D"margin:0px;display:inline!important"><span style=
=3D"color:rgb(80,0,80);border-collapse:collapse"><font color=3D"#67b545"><b=
>--</b></font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><span style=3D"color:rgb(80,0,80);border-collapse:col=
lapse"><font color=3D"#67b545"><b><br></b></font></span></div></div><div st=
yle=3D"border-collapse:collapse">
<div style=3D"margin:0px;display:inline!important"><span style=3D"color:rgb=
(80,0,80);border-collapse:collapse"><font color=3D"#67b545"><b>o</b></font>=
=A0</span><span style=3D"border-collapse:collapse"><font color=3D"#000000">=
Energy-efficiency is #1 reason data centers look to expand. =A0-- Digital R=
ealty Trust</font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><font style=3D"color:rgb(51,204,0)"><b style=3D"color=
:rgb(103,181,69)">o</b>=A0</font><font color=3D"#000000">Green Data Centers=
 spending to increase 300% worldwide by 2016. =A0-- Pike Research</font></d=
iv>
</div></span></div><div style=3D"font-family:Arial;font-size:12px"><div sty=
le=3D"margin:0px"><b style=3D"color:rgb(103,181,69)">o=A0</b><font color=3D=
"#000000">Data Centers have=A0become as vital to the=A0functioni</font><div=
 style=3D"margin:0px;display:inline!important">
<font color=3D"#000000">ng</font><font color=3D"#000000">=A0of society as p=
ower stations. =A0-- The Economist</font></div></div><div style=3D"margin:0=
px"><br></div></div></div>
</div>

--f46d044630a81ecbf004f4fd98fb--
