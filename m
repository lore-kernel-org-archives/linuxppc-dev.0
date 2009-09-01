Return-Path: <hongwoo7@gmail.com>
MIME-Version: 1.0
Date: Tue, 1 Sep 2009 19:58:32 +0900
Message-ID: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>
Subject: Question about linux boot procedure (head_64.S)
From: Lee HongWoo <hongwoo7@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00c09f8fea9b092efd04728208c3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f8fea9b092efd04728208c3
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

--00c09f8fea9b092efd04728208c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ~ <br><br>This is a boot flow of linux kernel under the arch/powerpc/ker=
nel and I&#39;m using pasemi cpu. <br><br>__start=A0 (in head_64.S) <br>=A0=
 ---&gt; __start_initialization_multiplatform (in head_64.S) <br>=A0 =A0 --=
-&gt; __boot_from_prom (in head_64.S) <br>

=A0=A0=A0=A0=A0=A0 ---&gt; prom_init ( in prom_init.c) <br>=A0 =A0 =A0 =A0=
=A0 ---&gt; __start ???<br><br>And I don&#39;t understand where __start is =
called, because I can find __start only in head_64.S. <br>If it calls __sta=
rt in head_64.S, it&#39;s a recursive call. <br>

<br>Can anybody explain about this precedure ? <br><br>Thanks in advance. <=
br><br>HongWoo. <br><br><br><br><br>

--00c09f8fea9b092efd04728208c3--
