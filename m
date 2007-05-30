Return-Path: <Ulrich.Weigand@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2273CDE007
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:08:57 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4UD8rVD186772
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 13:08:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4UD8rZk4014162
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:08:53 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4UD8rHp008042
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:08:53 +0200
In-Reply-To: <1180474900.19517.203.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: [RFC/PATCH 5/5] powerpc: Allow ptrace write to pt_regs trap
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OFE2492789.46B7D00B-ON422572EB.0045F2F2-422572EB.0048392E@de.ibm.com>
Date: Wed, 30 May 2007 15:08:52 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 00460DE5422572EB_="
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00460DE5422572EB_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/29/2007=20
11:41:40 PM:

> On Tue, 2007-05-29 at 17:41 +0200, Ulrich Weigand wrote:
> > This doesn't look sufficient.  If you want GDB to use the save/=20
> > restore style means of handling interrupted calls (like i386),=20
> > at the very least we also need the capability to *write* the=20
> > orig=5Fgpr3 field, which is currently prohibited.  (I don't know=20
> > why this is case, though.)=20
>=20
> It's not prohibited afaik ... we allow writing to everything <=3D MQ (39)
> on 32 bits and <=3D CCR (38) on 64 bits and ORIG=5FR3 qualifies (34)

Um?  I see this in the PTRACE=5FPOKEUSR case in arch=5Fptrace:

                if (index =3D=3D PT=5FORIG=5FR3)
                        break;



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--=20
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  GNU compiler/toolchain for Linux on System z and Cell BE
  IBM Deutschland Entwicklung GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch=E4ftsf=FChrung:=20
Herbert Kircher
  Sitz der Gesellschaft: B=F6blingen | Registergericht: Amtsgericht=20
Stuttgart, HRB 243294

--=_alternative 00460DE5422572EB_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2><tt>Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&=
gt;
wrote on 05/29/2007 11:41:40 PM:<br>
<br>
&gt; On Tue, 2007-05-29 at 17:41 +0200, Ulrich Weigand wrote:<br>
&gt; &gt; This doesn't look sufficient. &nbsp;If you want GDB to use the
save/ <br>
&gt; &gt; restore style means of handling interrupted calls (like i386),
<br>
&gt; &gt; at the very least we also need the capability to *write* the
<br>
&gt; &gt; orig=5Fgpr3 field, which is currently prohibited. &nbsp;(I don't
know <br>
&gt; &gt; why this is case, though.) <br>
&gt; <br>
&gt; It's not prohibited afaik ... we allow writing to everything &lt;=3D
MQ (39)<br>
&gt; on 32 bits and &lt;=3D CCR (38) on 64 bits and ORIG=5FR3 qualifies (34=
)</tt></font>
<br>
<br><font size=3D2><tt>Um? &nbsp;I see this in the PTRACE=5FPOKEUSR case in
arch=5Fptrace:</tt></font>
<br>
<br><font size=3D2><tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
if (index =3D=3D PT=5FORIG=5FR3)</tt></font>
<br><font size=3D2><tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp; &nbsp; &nbsp; break;</tt></font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif"><br>
Mit freundlichen Gruessen / Best Regards<br>
<br>
Ulrich Weigand<br>
<br>
-- <br>
 &nbsp;Dr. Ulrich Weigand | Phone: +49-7031/16-3727<br>
 &nbsp;GNU compiler/toolchain for Linux on System z and Cell BE<br>
 &nbsp;IBM Deutschland Entwicklung GmbH<br>
 &nbsp;Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch=E4ftsf=FChrung:
Herbert Kircher<br>
 &nbsp;Sitz der Gesellschaft: B=F6blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294</font>
<br>
--=_alternative 00460DE5422572EB_=--
