Return-Path: <rredondo@indra.es>
Received: from madarrsmtp2.indra.es (unknown [213.170.46.108])
	by ozlabs.org (Postfix) with ESMTP id 5058368802
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 21:41:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5F72B.E02C6080"
Date: Fri, 2 Dec 2005 11:33:46 +0100
Message-ID: <6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es>
From: "Redondo Garcia, Roberto" <rredondo@indra.es>
To: <linuxppc-dev@ozlabs.org>
Subject: back trace when a SIGSEGV
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F72B.E02C6080
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hello,=20
I have a program that when it has been several hours running, it has a
problem and falls and it produces a SIGSEGV.  I would like to know to
how debug this error, because I do not have ulimit for generate core
dump o examine a back trace.
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

------_=_NextPart_001_01C5F72B.E02C6080
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<META content=3D"MSHTML 6.00.2900.2668" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial size=3D2>hello,=20=

</FONT></SPAN></DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial><FONT size=3D2>I=
 have a=20
program that when it has been several hours&nbsp;<SPAN=20
class=3D637013110-02122005>running</SPAN>, it has a problem and falls and=
 it=20
produces a SIGSEGV.&nbsp; I would like to know to how debug this error, b=
ecause=20
I do not have ulimit for generate core dump<SPAN class=3D637013110-021220=
05> o=20
examine a back trace.</SPAN></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial=20
size=3D2>thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D157352607-02122005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV></DIV>--------------------------------=
-------------------------------------------------------------------------=
----------<br>Este correo electr=F3nico y, en su caso, cualquier fichero =
anexo al mismo, contiene informaci=F3n de car=E1cter confidencial exclusi=
vamente dirigida a su destinatario o destinatarios. Queda prohibida su di=
vulgaci=F3n, copia o distribuci=F3n a terceros sin la previa autorizaci=F3=
n escrita de Indra. En el caso de haber recibido este correo electr=F3nic=
o por error, se ruega notificar inmediatamente esta circunstancia mediant=
e reenv=EDo a la direcci=F3n electr=F3nica del remitente. POR FAVOR, ANTE=
S DE IMPRIMIR ESTE CORREO ELECTR=D3NICO CONSIDERE SU APORTACI=D3N A LA CO=
NSERVACI=D3N DEL MEDIO AMBIENTE POR LA REDUCCI=D3N DE CONSUMO DE PAPEL.<b=
r><br>The information in this e-mail and in any attachments is confidenti=
al and solely for the attention and use of the named addressee(s). You ar=
e hereby notified that any dissemination, distribution or copy of this co=
mmunication is prohibited without the prior written consent of Indra. If =
you have received this communication in error, please, notify the sender =
by reply e-mail. PLEASE CONSIDER YOUR ENVIRONMENTAL RESPONSIBILITY BEFORE=
 PRINTING THIS E-MAIL.</BODY></HTML>

------_=_NextPart_001_01C5F72B.E02C6080--
