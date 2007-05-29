Return-Path: <Ulrich.Weigand@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE188DE009
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:08:51 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4TE8lGZ253462
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:08:47 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4TE8lee3629084
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:08:47 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4TE8hXK020503
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:08:47 +0200
In-Reply-To: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
To: Steve Munroe <sjmunroe@us.ibm.com>
MIME-Version: 1.0
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
Date: Tue, 29 May 2007 16:08:39 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004D8A7D422572EA_="
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004D8A7D422572EA_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Steve Munroe <sjmunroe@us.ibm.com> wrote on 05/29/2007 04:00:42 PM:

> Yes exactly why make an incompatible ABI change to the powerp32 ABI,=20
when
> you can just use the existing 64-bit ABI.
>=20
> Especially as you can only run what is proposed on 64-bit hardware!
>=20
> We don't need another ABI change to powerpc32 (still recovering from the
> -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.
>=20
> ABI changes ripple everywhere (not just GCC/GLIBC) including all=20
debuggers
> and performance tools. Believe me you really don't want this.

Fully agreed.  This may have gotten lost in the discussion thread, but=20
what
Ben originally proposed was *not* an ABI change, for exactly that reason.
We simply want to allow strictly local use of 64-bit registers for
performance optimization purposes, while still fully complying with
the 32-bit ABI.


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

--=_alternative 004D8A7D422572EA_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2><tt>Steve Munroe &lt;sjmunroe@us.ibm.com&gt; wrote on
05/29/2007 04:00:42 PM:<br>
<br>
&gt; Yes exactly why make an incompatible ABI change to the powerp32 ABI,
when<br>
&gt; you can just use the existing 64-bit ABI.<br>
&gt; <br>
&gt; Especially as you can only run what is proposed on 64-bit hardware!<br>
&gt; <br>
&gt; We don't need another ABI change to powerpc32 (still recovering from
the<br>
&gt; -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.<br>
&gt; <br>
&gt; ABI changes ripple everywhere (not just GCC/GLIBC) including all debug=
gers<br>
&gt; and performance tools. Believe me you really don't want this.</tt></fo=
nt>
<br>
<br><font size=3D2><tt>Fully agreed. &nbsp;This may have gotten lost in the
discussion thread, but what</tt></font>
<br><font size=3D2><tt>Ben originally proposed was *not* an ABI change, for
exactly that reason.</tt></font>
<br><font size=3D2><tt>We simply want to allow strictly local use of 64-bit
registers for</tt></font>
<br><font size=3D2><tt>performance optimization purposes, while still fully
complying with</tt></font>
<br><font size=3D2><tt>the 32-bit ABI.</tt></font>
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
--=_alternative 004D8A7D422572EA_=--
