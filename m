Return-Path: <hongwoo7@gmail.com>
Received: from mail-vw0-f188.google.com (mail-vw0-f188.google.com
	[209.85.212.188])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8CDF5B7B71
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 21:27:28 +1000 (EST)
Received: by vws26 with SMTP id 26so3586755vws.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 01 Sep 2009 04:27:26 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 1 Sep 2009 20:27:25 +0900
Message-ID: <5e2889710909010427u98ad674gc1b019ed2046660@mail.gmail.com>
Subject: Question about linux boot procedure (head_64.S)
From: Lee HongWoo <hongwoo7@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=0016e6475bea4964ef0472826fa8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6475bea4964ef0472826fa8
Content-Type: text/plain; charset=ISO-8859-1

Hi ~

This is a boot flow of linux kernel under the arch/powerpc/kernel and I'm
using pasemi cpu.

__start  (in head_64.S)
  ---> __start_initialization_multiplatform (in head_64.S)
    ---> __boot_from_prom (in head_64.S)
       ---> prom_init ( in prom_init.c)
         ---> __start ???

And I don't understand where __start is called, because I can find __start
only in head_64.S.
If it calls __start in head_64.S, it's a recursive call.

Can anybody explain about this precedure ?

Thanks in advance.

HongWoo.

--0016e6475bea4964ef0472826fa8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ~ <br><br>This is a boot flow of linux kernel under the arch/powerpc/ker=
nel and I&#39;m using pasemi cpu. <br><br>__start=A0 (in head_64.S) <br>=A0=
 ---&gt; __start_initialization_<div>multiplatform (in head_64.S) <br>
=A0 =A0 ---&gt; __boot_from_prom (in head_64.S) <br>

=A0=A0=A0=A0=A0=A0 ---&gt; prom_init ( in prom_init.c) <br>=A0 =A0 =A0 =A0=
=A0 ---&gt; __start ???<br><br>And I don&#39;t understand where __start is =
called, because I can find __start only in head_64.S. <br>If it calls __sta=
rt in head_64.S, it&#39;s a recursive call. <br>




<br>Can anybody explain about this precedure ? <br><br>Thanks in advance. <=
br><font color=3D"#888888"><br>HongWoo. </font></div>

--0016e6475bea4964ef0472826fa8--
