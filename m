Return-Path: <rredondo@indra.es>
Received: from madarrsmtp2.indra.es (unknown [213.170.46.108])
	by ozlabs.org (Postfix) with ESMTP id 6774568802
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 18:43:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5F713.15559DE5"
Date: Fri, 2 Dec 2005 08:36:16 +0100
Message-ID: <6A28467355D2AD478D1F51C479415AE77B4592@MADTORMAIL.indra.es>
From: "Redondo Garcia, Roberto" <rredondo@indra.es>
To: <linuxppc-embedded@ozlabs.org>
Subject: SIGSEV in user mode
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

------_=_NextPart_001_01C5F713.15559DE5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hello,=20
I have a program that when it has been several hours executing, it has a
problem and falls and it produces a SIGSEGV.  I would like to know to
how debug this error, because I do not have ulimit for generate core
dump
=20
thanks
=20
-------------------------------------------------------------------------=
------------------------------------------
Este correo electr=F3nico y, en su caso, cualquier fichero anexo al mismo=
, contiene informaci=F3n de car=E1cter confidencial exclusivamente dirigi=
da a su destinatario o destinatarios. Queda prohibida su divulgaci=F3n, c=
opia o distribuci=F3n a terceros sin la previa autorizaci=F3n escrita de =
Indra. En el caso de haber recibido este correo electr=F3nico por error, =
se ruega notificar inmediatamente esta circunstancia mediante reenv=EDo a=
 la direcci=F3n electr=F3nica del remitente. POR FAVOR, ANTES DE IMPRIMIR=
 ESTE CORREO ELECTR=D3NICO CONSIDERE SU APORTACI=D3N A LA CONSERVACI=D3N =
DEL MEDIO AMBIENTE POR LA REDUCCI=D3N DE CONSUMO DE PAPEL.

The information in this e-mail and in any attachments is confidential and=
 solely for the attention and use of the named addressee(s). You are here=
by notified that any dissemination, distribution or copy of this communic=
ation is prohibited without the prior written consent of Indra. If you ha=
ve received this communication in error, please, notify the sender by rep=
ly e-mail. PLEASE CONSIDER YOUR ENVIRONMENTAL RESPONSIBILITY BEFORE PRINT=
ING THIS E-MAIL.

------_=_NextPart_001_01C5F713.15559DE5
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<META content=3D"MSHTML 6.00.2900.2668" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial size=3D2>hello,=20=

</FONT></SPAN></DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial size=3D2>I have =
a program=20
that when it has been several hours executing, it has a problem and falls=
 and it=20
produces a SIGSEGV.&nbsp; I would like to know to how debug this error, b=
ecause=20
I do not have ulimit for generate core dump</FONT></SPAN></DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial=20
size=3D2>thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>--------------------------------------=
-------------------------------------------------------------------------=
----<br>Este correo electr=F3nico y, en su caso, cualquier fichero anexo =
al mismo, contiene informaci=F3n de car=E1cter confidencial exclusivament=
e dirigida a su destinatario o destinatarios. Queda prohibida su divulgac=
i=F3n, copia o distribuci=F3n a terceros sin la previa autorizaci=F3n esc=
rita de Indra. En el caso de haber recibido este correo electr=F3nico por=
 error, se ruega notificar inmediatamente esta circunstancia mediante ree=
nv=EDo a la direcci=F3n electr=F3nica del remitente. POR FAVOR, ANTES DE =
IMPRIMIR ESTE CORREO ELECTR=D3NICO CONSIDERE SU APORTACI=D3N A LA CONSERV=
ACI=D3N DEL MEDIO AMBIENTE POR LA REDUCCI=D3N DE CONSUMO DE PAPEL.<br><br=
>The information in this e-mail and in any attachments is confidential an=
d solely for the attention and use of the named addressee(s). You are her=
eby notified that any dissemination, distribution or copy of this communi=
cation is prohibited without the prior written consent of Indra. If you h=
ave received this communication in error, please, notify the sender by re=
ply e-mail. PLEASE CONSIDER YOUR ENVIRONMENTAL RESPONSIBILITY BEFORE PRIN=
TING THIS E-MAIL.</BODY></HTML>

------_=_NextPart_001_01C5F713.15559DE5--
