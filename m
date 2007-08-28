Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 63477DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 04:56:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E9A5.19551EAD"
Subject: ppc_8xx-gcc from eldk strange behaviour
Date: Tue, 28 Aug 2007 20:56:10 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E2649AF@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7E9A5.19551EAD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Consider the following C code snippet:

#include <stdio.h>

int main()
{
  char x =3D -4;
   =20
  if (x < 0)
    printf("x is negative\n");
  else
    printf("x is positive\n"); =20
}

If I compile it with host gcc, there is no warning and the message "x is =
negative" is printed.
If I compile it with ppc_8xx-gcc there is a warning "main.c:11: warning: =
comparison is always false due to limited range of data type" and the =
program prints message "x is positive".=20
To correct the problem I have to put signed before char.

Bye,
Antonio.

------_=_NextPart_001_01C7E9A5.19551EAD
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>ppc_8xx-gcc from eldk strange behaviour</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Consider the following C code snippet:<BR>
<BR>
#include &lt;stdio.h&gt;<BR>
<BR>
int main()<BR>
{<BR>
&nbsp; char x =3D -4;<BR>
&nbsp;&nbsp;&nbsp;<BR>
&nbsp; if (x &lt; 0)<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;x is negative\n&quot;);<BR>
&nbsp; else<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;x is positive\n&quot;);&nbsp;<BR>
}<BR>
<BR>
If I compile it with host gcc, there is no warning and the message =
&quot;x is negative&quot; is printed.<BR>
If I compile it with ppc_8xx-gcc there is a warning &quot;main.c:11: =
warning: comparison is always false due to limited range of data =
type&quot; and the program prints message &quot;x is positive&quot;.<BR>
To correct the problem I have to put signed before char.<BR>
<BR>
Bye,<BR>
Antonio.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7E9A5.19551EAD--
