Return-Path: <safahamza1@gmail.com>
Received: from mail-oi0-x22a.google.com (mail-oi0-x22a.google.com
 [IPv6:2607:f8b0:4003:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFn4T2YWzzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 21:30:01 +1000 (AEST)
Received: by mail-oi0-x22a.google.com with SMTP id k23so119460380oih.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 04:30:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1128bc83-dcaa-718b-4faf-0a58b789dbec@c-s.fr>
References: <CAFwQ9hGFeC2700F3yy4vYVNdbO3vid=9hH_qO-5PbOuRDAHGdw@mail.gmail.com>
 <1128bc83-dcaa-718b-4faf-0a58b789dbec@c-s.fr>
Date: Thu, 26 May 2016 12:29:57 +0100
Message-ID: <CAFwQ9hFt7Zh2CRvLKh-7wi4yxJi3vd8ddPPNxcniKQ+KiuM3WQ@mail.gmail.com>
Subject: Re: powerpc cross compiler issue
From: Safa Hamza <safahamza1@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a113d35b02194e80533bd1c18
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113d35b02194e80533bd1c18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ----------
From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, May 26, 2016 at 11:02 AM
Subject: Re: powerpc cross compiler issue
To: Safa Hamza <safahamza1@gmail.com>, linuxppc-dev@lists.ozlabs.org



Le 26/05/2016 =C3=A0 11:05, Safa Hamza a =C3=A9crit :

> hello every one
> please can any one suggest to me a powerpc cross compiler package or from
> source, i have downloaded  cross compiler package such as powerpc64le and=
 i
> got a little endian and big endian problem, i have tried also to download
> eldk cross compiler but i didn't know how
> any suggestion please
>

https://www.kernel.org/pub/tools/crosstool/


Christophe

thanks for replying, I tried a powerpc cross compiler from the list you
have send but I always got this error

 VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
/home/marwa/Bureau/lauterbach/powerpc/gcc-4.6.3-nolibc/powerpc64-linux/bin/=
../lib/gcc/powerpc64-linux/4.6.3/../../../../powerpc64-linux/bin/ld:
arch/powerpc/kernel/vdso32/note.o: compiled for a little endian system and
target is big endian
/home/marwa/Bureau/lauterbach/powerpc/gcc-4.6.3-nolibc/powerpc64-linux/bin/=
../lib/gcc/powerpc64-linux/4.6.3/../../../../powerpc64-linux/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/note.o
collect2: ld returned 1 exit status
make[2]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Erreur 1
make[1]: *** [arch/powerpc/kernel/vdso32] Erreur 2
make: *** [arch/powerpc/kernel] Erreur 2


the kernel was configured with ppc64_defconfig (linux-4.4.1)

--001a113d35b02194e80533bd1c18
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br><div class=3D"gmail_quote">---------- Forwarded m=
essage ----------<br>From: <b class=3D"gmail_sendername">Christophe Leroy</=
b> <span dir=3D"ltr">&lt;<a href=3D"mailto:christophe.leroy@c-s.fr">christo=
phe.leroy@c-s.fr</a>&gt;</span><br>Date: Thu, May 26, 2016 at 11:02 AM<br>S=
ubject: Re: powerpc cross compiler issue<br>To: Safa Hamza &lt;<a href=3D"m=
ailto:safahamza1@gmail.com">safahamza1@gmail.com</a>&gt;, <a href=3D"mailto=
:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozlabs.org</a><br><br><b=
r><span class=3D""><br>
Le 26/05/2016 =C3=A0 11:05, Safa Hamza a =C3=A9crit :<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
hello every one<br>
please can any one suggest to me a powerpc cross compiler package or from s=
ource, i have downloaded=C2=A0 cross compiler package such as powerpc64le a=
nd i got a little endian and big endian problem, i have tried also to downl=
oad eldk cross compiler but i didn&#39;t know how<br>
any suggestion please<br>
</blockquote>
<br>
</span><a href=3D"https://www.kernel.org/pub/tools/crosstool/" rel=3D"noref=
errer" target=3D"_blank">https://www.kernel.org/pub/tools/crosstool/</a><sp=
an class=3D""><font color=3D"#888888"><br></font></span></div><div class=3D=
"gmail_quote"><span class=3D""><font color=3D"#888888"><br></font></span></=
div><div class=3D"gmail_quote"><span class=3D""><font color=3D"#888888">
<br>
Christophe<br>
</font></span></div><div class=3D"gmail_quote"><span class=3D""><font color=
=3D"#888888"><br></font></span></div>thanks for replying, I tried a powerpc=
 cross compiler from the list you have send but I always got this error <br=
>=C2=A0<br>=C2=A0VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg<br>/home/=
marwa/Bureau/lauterbach/powerpc/gcc-4.6.3-nolibc/powerpc64-linux/bin/../lib=
/gcc/powerpc64-linux/4.6.3/../../../../powerpc64-linux/bin/ld: arch/powerpc=
/kernel/vdso32/note.o: compiled for a little endian system and target is bi=
g endian<br>/home/marwa/Bureau/lauterbach/powerpc/gcc-4.6.3-nolibc/powerpc6=
4-linux/bin/../lib/gcc/powerpc64-linux/4.6.3/../../../../powerpc64-linux/bi=
n/ld: failed to merge target specific data of file arch/powerpc/kernel/vdso=
32/note.o<br>collect2: ld returned 1 exit status<br>make[2]: *** [arch/powe=
rpc/kernel/vdso32/vdso32.so.dbg] Erreur 1<br>make[1]: *** [arch/powerpc/ker=
nel/vdso32] Erreur 2<br>make: *** [arch/powerpc/kernel] Erreur 2<br><br><br=
></div>the kernel was configured with ppc64_defconfig (linux-4.4.1)<br></di=
v>

--001a113d35b02194e80533bd1c18--
